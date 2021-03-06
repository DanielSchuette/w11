-- $Id: tb_tst_rlink_arty.vhd 1181 2019-07-08 17:00:50Z mueller $
-- SPDX-License-Identifier: GPL-3.0-or-later
-- Copyright 2016- by Walter F.J. Mueller <W.F.J.Mueller@gsi.de>
--
------------------------------------------------------------------------------
-- Module Name:    tb_tst_rlink_arty
-- Description:    Configuration for tb_tst_rlink_arty for tb_arty
--
-- Dependencies:   sys_tst_rlink_arty
--
-- To test:        sys_tst_rlink_arty
--
-- Revision History: 
-- Date         Rev Version  Comment
-- 2016-02-14   731   1.0    Initial version 
------------------------------------------------------------------------------

configuration tb_tst_rlink_arty of tb_arty is

  for sim
    for all : arty_aif
      use entity work.sys_tst_rlink_arty;
    end for;
  end for;

end tb_tst_rlink_arty;
