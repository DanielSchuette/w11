// $Id: Rw11RdmaDisk.hpp 1186 2019-07-12 17:49:59Z mueller $
// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright 2015-2018 by Walter F.J. Mueller <W.F.J.Mueller@gsi.de>
// 
// Revision History: 
// Date         Rev Version  Comment
// 2018-12-15  1083   1.0.2  for std::function setups: use rval ref and move
// 2017-04-02   865   1.0.1  Dump(): add detail arg
// 2015-01-04   627   1.0    Initial version
// ---------------------------------------------------------------------------


/*!
  \brief   Declaration of class Rw11RdmaDisk.
*/

#ifndef included_Retro_Rw11RdmaDisk
#define included_Retro_Rw11RdmaDisk 1

#include <vector>

#include "Rw11Rdma.hpp"
#include "Rw11UnitDisk.hpp"

namespace Retro {

  class Rw11RdmaDisk : public Rw11Rdma {
    public:
                    Rw11RdmaDisk(Rw11Cntl* pcntl, precb_t&& precb, 
                                 postcb_t&& postcb);
                   ~Rw11RdmaDisk();

      void          QueueDiskRead(uint32_t addr, size_t size, uint16_t mode, 
                                  uint32_t lba, Rw11UnitDisk* punit);
      void          QueueDiskWrite(uint32_t addr, size_t size, uint16_t mode, 
                                   uint32_t lba, Rw11UnitDisk* punit);
      void          QueueDiskWriteCheck(uint32_t addr, size_t size, 
                                        uint16_t mode, uint32_t lba, 
                                        Rw11UnitDisk* punit);

      size_t        WriteCheck(size_t nwdone); 

      virtual void  Dump(std::ostream& os, int ind=0, const char* text=0,
                         int detail=0) const;

    // statistics counter indices
      enum stats {
        kStatNWritePadded = Rw11Rdma::kDimStat,//!< padded disk write
        kStatNWChkFail,                        //!< write check failed
        kDimStat
      };
    
    protected:
    // function code values
      enum func {
        kFuncRead,                          //!< read function
        kFuncWrite,                         //!< write function
        kFuncWriteCheck                     //!< write check function
      };

      void          SetupDisk(size_t size, uint32_t lba, Rw11UnitDisk* punit, 
                              Rw11RdmaDisk::func func);
      virtual void  PreRdmaHook();
      virtual void  PostRdmaHook(size_t nwdone);

    protected:
      std::vector<uint16_t>  fBuf;          //!< data buffer
      Rw11UnitDisk* fpUnit;                 //!< UnitDisk to read VirtDisk
      size_t        fNWord;                 //!< words to transfer
      size_t        fNBlock;                //!< disk blocks to transfer
      size_t        fLba;                   //!< disk lba
      enum func     fFunc;                  //!< current function
  };
  
} // end namespace Retro

#include "Rw11RdmaDisk.ipp"

#endif
