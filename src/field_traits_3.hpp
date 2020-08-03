// Auto-generated; do not edit.
#pragma once
#include <stdint.h>
#include "field.hpp"

extern "C" {
#include "teki_3.h"
}
template<> struct Field_traits<3>
{
 static inline uint64_t add(uint64_t* a0, const uint64_t* a1)
 {
  return teki_add_3(a0, const_cast<uint64_t*>(a1));
 }
 static inline uint64_t sub(uint64_t* a0, const uint64_t* a1)
 {
  return teki_sub_3(a0, const_cast<uint64_t*>(a1));
 }
 static inline uint64_t add_masked(uint64_t* a0, const uint64_t* a1, uint64_t a2)
 {
  return teki_add_masked_3(a0, const_cast<uint64_t*>(a1), a2);
 }
 static inline uint64_t sub_masked(uint64_t* a0, const uint64_t* a1, uint64_t a2)
 {
  return teki_sub_masked_3(a0, const_cast<uint64_t*>(a1), a2);
 }
 static inline uint64_t cmplt(const uint64_t* a0, const uint64_t* a1)
 {
  return teki_cmplt_3(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1));
 }
 static inline uint64_t cmple(const uint64_t* a0, const uint64_t* a1)
 {
  return teki_cmple_3(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1));
 }
 static inline uint64_t cmpeq(const uint64_t* a0, const uint64_t* a1)
 {
  return teki_cmpeq_3(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1));
 }
 static inline void mul_normal(const uint64_t* a0, const uint64_t* a1, uint64_t* a2)
 {
  return teki_mul_3(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1), a2);
 }
 static inline void mul_lo(const uint64_t* a0, const uint64_t* a1, uint64_t* a2)
 {
  return teki_mul_lo_3(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1), a2);
 }
 static inline void mul_barrett(const uint64_t* a0, const uint64_t* a1, uint64_t* a2)
 {
  return teki_mul_6_4(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1), a2);
 }
 static inline void copyfw(uint64_t* a0, const uint64_t* a1)
 {
  return teki_copyfw_3(a0, const_cast<uint64_t*>(a1));
 }
 static inline void copybw(uint64_t* a0, const uint64_t* a1)
 {
  return teki_copybw_3(a0, const_cast<uint64_t*>(a1));
 }
 static inline void setzlow(uint64_t* a0, uint64_t a1)
 {
  return teki_setzlow_3(a0, a1);
 }
}
