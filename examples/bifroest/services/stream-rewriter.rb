service "stream-rewriter" {
    aspect "logging" {
        file "log4j" {
            apply => write_to "/etc/bifroest/stream-rewriter/log4j.xml"
        }
        file "logrotate" {
            apply => write_to "/etc/logrotate.d/bifroest-stream-rewriter"
        }
        file "bash aliases" {
            apply => write_to "/etc/profile.d/bifroest-streamrewriter"
        }
    }
    aspect "retention" {
        file "retention" {
            apply => write_to "/etc/bifroest/stream-rewriter/retention.conf"
            reload => shell_command "graphite-json-client stream-rewriter reload-config"
        }
    }
    aspect "basic" {
        fileset "system" {
            apply => write_to "/etc/bifroest/stream-rewriter/"
            reload => restart_service "bifroest-stream-rewriter"
        }
    }
}

source "bifroest-*:stream-rewriter:logging" {
    checkout 'server-profiling/bifroest-config'
    stdout_from "/usr/bin/logging_manager log4j ${GIT_CHECKOUT}/live/stream-rewriter/logging.json
}

source "test-bifroest-*:stream-rewriter:logging {
    checkout 'server-profiling/bifroest-config'
    stdout_from "/usr/bin/logging_manager log4j test/stream-rewriter/logging.json"
}

source "bifroest-*:stream-rewriter:retention" {
    checkout 'server-profiling/bifroest-config'
    contents_of "live/retention.conf
}

source "test-bifroest-*:stream-rewriter:retention {
    checkout 'server-profiling/bifroest-config'
    contents_of "test/retention.conf"
}

source "bifroest-*:stream-rewriter:basic" {
    checkout 'server-profiling/bifroest-config'
    contents_of "live/stream-rewriter/application
}

source "test-bifroest-*:stream-rewriter:basic {
    checkout 'server-profiling/bifroest-config'
    contents_of "test/stream-rewriter/application"
}
