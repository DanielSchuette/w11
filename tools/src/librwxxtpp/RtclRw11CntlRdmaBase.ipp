// $Id: RtclRw11CntlRdmaBase.ipp 1186 2019-07-12 17:49:59Z mueller $
// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright 2017-2019 by Walter F.J. Mueller <W.F.J.Mueller@gsi.de>
// 
// Revision History: 
// Date         Rev Version  Comment
// 2019-02-23  1114   1.2.2  use std::bind instead of lambda
// 2018-12-15  1082   1.2.1  use lambda instead of boost::bind
// 2017-04-16   877   1.2    add class in ctor
// 2017-02-04   848   1.1    add in fGets: found,pdataint,pdatarem
// 2013-03-06   495   1.0    Initial version
// 2013-02-08   484   0.1    First draft
// ---------------------------------------------------------------------------

/*!
  \brief   Implemenation (all inline) of RtclRw11CntlRdmaBase.
*/

/*!
  \class Retro::RtclRw11CntlRdmaBase
  \brief FIXME_docs
*/

#include <functional>

#include "librtcltools/Rtcl.hpp"
#include "librtcltools/RtclOPtr.hpp"

// all method definitions in namespace Retro
namespace Retro {

//------------------------------------------+-----------------------------------
//! Constructor

template <class TC>
inline RtclRw11CntlRdmaBase<TC>::RtclRw11CntlRdmaBase(const std::string& type,
                                                      const std::string& cclass)
  : RtclRw11CntlBase<TC>(type,cclass)
{
  TC* pobj = &this->Obj();
  RtclGetList& gets = this->fGets;
  RtclSetList& sets = this->fSets;
  gets.Add<size_t>  ("chunksize", std::bind(&TC::ChunkSize,    pobj));
  sets.Add<size_t>  ("chunksize", std::bind(&TC::SetChunkSize, pobj,
                                            std::placeholders::_1));
}

//------------------------------------------+-----------------------------------
//! FIXME_docs

template <class TC>
inline RtclRw11CntlRdmaBase<TC>::~RtclRw11CntlRdmaBase()
{}


} // end namespace Retro
