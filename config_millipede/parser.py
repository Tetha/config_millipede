
class Parser(object):
    def __init__(self, contents):
        self.contents = contents

        self.position = 0
        self.column = 0
        self.line = 0

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
