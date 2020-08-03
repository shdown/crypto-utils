// Auto-generated; do not edit.
#pragma once
#include <stdint.h>
#include "field.hpp"

extern "C" {
#include "teki_5.h"
}
template<> struct Field_traits<5>
{
 static inline uint64_t add(uint64_t* a0, const uint64_t* a1)
 {
  return teki_add_5(a0, const_cast<uint64_t*>(a1));
 }
 static inline uint64_t sub(uint64_t* a0, const uint64_t* a1)
 {
  return teki_sub_5(a0, const_cast<uint64_t*>(a1));
 }
 static inline uint64_t add_masked(uint64_t* a0, const uint64_t* a1, uint64_t a2)
 {
  return teki_add_masked_5(a0, const_cast<uint64_t*>(a1), a2);
 }
 static inline uint64_t sub_masked(uint64_t* a0, const uint64_t* a1, uint64_t a2)
 {
  return teki_sub_masked_5(a0, const_cast<uint64_t*>(a1), a2);
 }
 static inline uint64_t cmplt(const uint64_t* a0, const uint64_t* a1)
 {
  return teki_cmplt_5(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1));
 }
 static inline uint64_t cmple(const uint64_t* a0, const uint64_t* a1)
 {
  return teki_cmple_5(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1));
 }
 static inline uint64_t cmpeq(const uint64_t* a0, const uint64_t* a1)
 {
  return teki_cmpeq_5(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1));
 }
 static inline void mul_normal(const uint64_t* a0, const uint64_t* a1, uint64_t* a2)
 {
  return teki_mul_5(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1), a2);
 }
 static inline void mul_lo(const uint64_t* a0, const uint64_t* a1, uint64_t* a2)
 {
  return teki_mul_lo_5(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1), a2);
 }
 static inline void mul_barrett(const uint64_t* a0, const uint64_t* a1, uint64_t* a2)
 {
  return teki_mul_10_6(const_cast<uint64_t*>(a0), const_cast<uint64_t*>(a1), a2);
 }
 static inline void copyfw(uint64_t* a0, const uint64_t* a1)
 {
  return teki_copyfw_5(a0, const_cast<uint64_t*>(a1));
 }
 static inline void copybw(uint64_t* a0, const uint64_t* a1)
 {
  return teki_copybw_5(a0, const_cast<uint64_t*>(a1));
 }
 static inline void setzlow(uint64_t* a0, uint64_t a1)
 {
  return teki_setzlow_5(a0, a1);
 }
}
