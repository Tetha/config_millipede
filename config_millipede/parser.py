
class Parser(object):
    def __init__(self, contents):
        self.contents = contents

        self.position = 0
        self.column = 0
        self.line = 0

    def funcall(self):
        """reads a function call with a single parameter

           >>> r = Parser('foo "bar"').funcall()
           >>> r[0]
           True
           >>> r[1]['function']
           'foo'
           >>> r[1]['parameter']
           'bar'
        """

        word_res = self.word()
        if not word_res[0]:
            raise SyntaxError("Cannot parse word at line %d, column %d", self.line, self.column)

        while self.contents[self.position] in ' \t':
            self.position += 1
            self.column += 1

        param_res = self.quoted_string()
        if param_res[0]:
            parameter = param_res[1]
        else:
            parameter = None
        return (True, { 'function' : word_res[1], 'parameter' : parameter })
        
    def word(self):
        """Reads a word, ie a sequence of alphanumeric characters

           >>> Parser('foo').word()
           (True, 'foo')
           >>> Parser('contents_of').word()
           (True, 'contents_of')
           >>> Parser('"blorb"').word()
           (False,)
        """
        word_char = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"
        result = ""
        while self.position < len(self.contents):
            if self.contents[self.position] not in word_char:
                break
            result += self.contents[self.position]
            self.position += 1
            self.column += 1
        if result == "":
            return (False,)
        else:
            return (True, result)

    def quoted_string(self):
        """Reads a quoted string at the current position. Supports escapes

           >>> Parser('"foo"').quoted_string()
           (True, 'foo')
           >>> Parser('"foo\\\\\"bar"').quoted_string()
           (True, 'foo"bar')
           >>> Parser("=> blub").quoted_string()
           (False,)
           >>> Parser('"foo').quoted_string()
           Traceback (most recent call last):
               ...
           SyntaxError: Unterminated string, started at line 0, column 0
        """
        
        if self.contents[self.position] != '"':
            return (False,)

        first_column_in_string = self.position
        self.position += 1
        string = ""
        while self.position < len(self.contents):
            if self.contents[self.position] == '"':
                break
            if self.contents[self.position] == '\\':
                # TODO: escapes
	        self.position += 1
            string += self.contents[self.position]
            self.position += 1
            self.column += 1

        
        if self.position >= len(self.contents):
            raise SyntaxError("Unterminated string, started at line %d, column %d" % (self.line, first_column_in_string))
        else:
            return (True, string)
