service "stream-rewriter" {
    aspect "logging" {
        fragment "log4j" {
            apply => write_to "/etc/bifroest/stream-rewriter/log4j.xml"
        }
        fragment "logrotate" {
            apply => write_to "/etc/logrotate.d/bifroest-stream-rewriter"
        }
        fragment "bash aliases" {
            apply => write_to "/etc/profile.d/bifroest-streamrewriter"
        }
    }
    aspect "retention" {
        reload => shell_command "bifroest-json-client stream-rewriter reload-config"
        fragment "retention" {
            apply => write_to "/etc/bifroest/stream-rewriter/retention.conf"
        }
    }
    aspect "fundamental" {
        reload => restart_service "bifroest-stream-rewriter"
        fragment "system/*.conf" {
            apply => write_to "/etc/bifroest/stream-rewriter/"
        }
    }
}

source "bifroest-*:stream-rewriter:logging" {
    checkout 'server-profiling/bifroest-config'
    fragment "log4j" {
        stdout_from "/usr/bin/logging_manager log4j live/stream-rewriter/logging.json"
    }
    fragment "logrotate" {
        stdout_from "/usr/bin/logging_manager logrotate live/stream-rewriter/logging.json"
    }
    fragment "bash_aliases" {
        stdout_from "/usr/bin/logging_manager bash_aliases live/stream-rewriter/logging.json"
    }
}

source "test-bifroest-*:stream-rewriter:logging" {
    checkout 'server-profiling/bifroest-config'
    fragment "log4j" {
        stdout_from "/usr/bin/logging_manager log4j live/stream-rewriter/logging.json"
    }
    fragment "logrotate" {
        stdout_from "/usr/bin/logging_manager logrotate live/stream-rewriter/logging.json"
    }
    fragment "bash_aliases" {
        stdout_from "/usr/bin/logging_manager bash_aliases live/stream-rewriter/logging.json"
    }
}

source "bifroest-*:stream-rewriter:retention" {
    checkout 'server-profiling/bifroest-config'
    fragment "retention" {
	    contents_of "live/retention.conf"
    }
}

source "test-bifroest-*:stream-rewriter:retention" {
    checkout 'server-profiling/bifroest-config'
    fragment "retention" {
        contents_of "test/retention.conf"
    }
}

source "bifroest-*:stream-rewriter:basic" {
    checkout 'server-profiling/bifroest-config'
    fragments_from_wildcard "live/stream-rewriter/application/*.conf"
}

source "test-bifroest-*:stream-rewriter:basic" {
    checkout 'server-profiling/bifroest-config'
    fragments_from_wildcard "test/stream-rewriter/application/*.conf"
}
