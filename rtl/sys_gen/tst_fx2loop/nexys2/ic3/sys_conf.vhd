-- $Id: sys_conf.vhd 453 2012-01-15 17:51:18Z mueller $
--
-- Copyright 2012- by Walter F.J. Mueller <W.F.J.Mueller@gsi.de>
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
-- Description:    Definitions for sys_tst_fx2loop_ic3_n2 (for synthesis)
--
-- Dependencies:   -
-- Tool versions:  xst 13.3; ghdl 0.29
-- Revision History: 
-- Date         Rev Version  Comment
-- 2012-01-15   453   1.0    Initial version 
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.slvtypes.all;

package sys_conf is

  constant sys_conf_clkfx_divide : positive   :=  1;
  constant sys_conf_clkfx_multiply : positive :=  2;

  constant sys_conf_fx2_type : string := "ic3";

  -- dummy values defs for generic parameters of as controller
  constant sys_conf_fx2_rdpwldelay : positive := 1;
  constant sys_conf_fx2_rdpwhdelay : positive := 1;
  constant sys_conf_fx2_wrpwldelay : positive := 1;
  constant sys_conf_fx2_wrpwhdelay : positive := 1;
  constant sys_conf_fx2_flagdelay  : positive := 1;

  -- pktend timer setting
  --   petowidth=10 -> 2^10 30 MHz clocks -> ~33 usec (normal operation)
  constant sys_conf_fx2_petowidth  : positive := 10;

  constant sys_conf_fx2_ccwidth  : positive := 5;
   
  constant sys_conf_hio_debounce : boolean := true;    -- instantiate debouncers

  -- derived constants
  
  constant sys_conf_clksys : integer :=
    (50000000/sys_conf_clkfx_divide)*sys_conf_clkfx_multiply;
  constant sys_conf_clksys_mhz : integer := sys_conf_clksys/1000000;

end package sys_conf;