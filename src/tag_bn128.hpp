#pragma once

#include <stdint.h>
#include "field_4.hpp"
#include "field.hpp"

struct Tag_BN128
{
    enum { W = 4 };

    static inline const Field<W> field = {
        {
            UINT64_C(4891460686036598785),
            UINT64_C(2896914383306846353),
            UINT64_C(13281191951274694749),
            UINT64_C(3486998266802970665),
        },
        {
            UINT64_C(2337432441630659161),
            UINT64_C(1461508241694919398),
            UINT64_C(12714969645072974151),
            UINT64_C(5352323811773532794),
            UINT64_C(5),
        },
    };
};
