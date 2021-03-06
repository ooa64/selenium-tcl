#!/usr/bin/tclsh

package require tcltest
tcltest::configure {*}$argv -singleproc true -testdir [file dirname [info script]]

lappend auto_path [file join [tcltest::testsDirectory] ..]
package require selenium
package require selenium::utils::log
selenium::utils::log::logctl open [file join [info script].log]
selenium::utils::log::logctl severity debug 1
selenium::utils::log::logctl severity TEST> 1

rename tcltest::test tcltest::__test
proc tcltest::test args {
    ::selenium::utils::log::log TEST> {[lindex $args 0]: ([string trim [lindex $args 1]])}
    uplevel 1 ::tcltest::__test $args
}

source [file join [tcltest::testsDirectory] testlib.tcl]

namespace import ::tcltest::*

#webConnect chromeDriver
webConnect

runAllTests

webDisconnect
