# $Id: 211bsd_rpmin_boot.tcl 1154 2019-05-30 13:21:01Z mueller $
#
# Setup file for 211bsd RP06 based minimal memory system
#
# Usage:
#   
# console_starter -d DL0 &
# console_starter -d DZ0 &
# ti_w11 -xxx @211bsd_rpmin_boot.tcl     ( -xxx depends on sim or fpga connect)
#

# setup w11 cpu
rutil::dohook "preinithook"
puts [rlw]

# setup tt,lp (211bsd uses parity -> use 7 bit mode)
rw11::setup_tt "cpu0" ndl 1 dlrxrlim 5 ndz 1 dzrxrlim 5 to7bit 1
rw11::setup_lp 

# mount disks
cpu0rpa0 set type rp06
cpu0rpa1 set type rp06

cpu0rpa0 att 211bsd_rpmin.dsk

# and boot
rutil::dohook "preboothook"
cpu0 boot rpa0
