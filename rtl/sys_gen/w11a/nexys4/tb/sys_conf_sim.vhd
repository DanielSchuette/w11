-- $Id: sys_conf_sim.vhd 647 2015-02-17 22:35:36Z mueller $
--
-- Copyright 2013-2015 by Walter F.J. Mueller <W.F.J.Mueller@gsi.de>
--
-- This program is free software; you may redistribute and/or modify it under
-- the terms of the GNU General Public License as published by the Free
-- Software Foundation, either version 2, or at your option any later version.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-- for complete details.
--
------------------------------------------------------------------------------
-- Package Name:   sys_conf
-- Description:    Definitions for sys_w11a_n4 (for simulation)
--
-- Dependencies:   -
-- Tool versions:  xst 14.5-14.7; ghdl 0.29-0.31
-- Revision History: 
-- Date         Rev Version  Comment
-- 2015-02-07   643   1.1    drop bram and minisys options
-- 2013-09-34   534   1.0    Initial version (cloned from _n3)
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.slvtypes.all;

package sys_conf is

  constant sys_conf_clksys_vcodivide   : positive :=   1;
  constant sys_conf_clksys_vcomultiply : positive :=   8;   -- vco  800 MHz
  constant sys_conf_clksys_outdivide   : positive :=  10;   -- sys   80 MHz
  constant sys_conf_clksys_gentype     : string   := "MMCM";
  -- single clock design, clkser = clksys
  constant sys_conf_clkser_vcodivide   : positive := sys_conf_clksys_vcodivide;
  constant sys_conf_clkser_vcomultiply : positive := sys_conf_clksys_vcomultiply;
  constant sys_conf_clkser_outdivide   : positive := sys_conf_clksys_outdivide;
  constant sys_conf_clkser_gentype     : string   := sys_conf_clksys_gentype;

  constant sys_conf_memctl_read0delay : positive := 6;   -- for 100 MHz
  constant sys_conf_memctl_read1delay : positive := sys_conf_memctl_read0delay;
  constant sys_conf_memctl_writedelay : positive := 7;

  constant sys_conf_ser2rri_cdinit : integer := 1-1;   -- 1 cycle/bit in sim
  
  constant sys_conf_hio_debounce : boolean := false;   -- no debouncers
    
  constant sys_conf_mem_losize     : integer := 8#167777#; --   4 MByte
--constant sys_conf_mem_losize     : integer := 8#003777#; -- 128 kByte (debug)

  constant sys_conf_cache_fmiss    : slbit   := '0';     -- cache enabled

  -- derived constants

  constant sys_conf_clksys : integer :=
    ((100000000/sys_conf_clksys_vcodivide)*sys_conf_clksys_vcomultiply) /
    sys_conf_clksys_outdivide;
  constant sys_conf_clksys_mhz : integer := sys_conf_clksys/1000000;

  constant sys_conf_clkser : integer :=
    ((100000000/sys_conf_clkser_vcodivide)*sys_conf_clkser_vcomultiply) /
    sys_conf_clkser_outdivide;
  constant sys_conf_clkser_mhz : integer := sys_conf_clkser/1000000;

end package sys_conf;

-- Note: mem_losize holds 16 MSB of the PA of the addressable memory
--        2 211 111 111 110 000 000 000
--        1 098 765 432 109 876 543 210
--
--        0 000 000 011 111 111 000 000  -> 00037777  --> 14bit -->  16 kByte
--        0 000 000 111 111 111 000 000  -> 00077777  --> 15bit -->  32 kByte
--        0 000 001 111 111 111 000 000  -> 00177777  --> 16bit -->  64 kByte
--        0 000 011 111 111 111 000 000  -> 00377777  --> 17bit --> 128 kByte
--        0 011 111 111 111 111 000 000  -> 03777777  --> 20bit -->   1 MByte
--        1 110 111 111 111 111 000 000  -> 16777777  --> 22bit -->   4 MByte
--                                          upper 256 kB excluded for 11/70 UB