#pragma once

#include <stdint.h>
#include "field_traits_4.hpp"
#include "field.hpp"
#include "elem.hpp"

namespace fi
{

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
        {
            UINT64_C(14042775128853446655),
            UINT64_C(7315682302672572851),
            UINT64_C(16400588293156512657),
            UINT64_C(8356480910413218226),
        },
        {
            UINT64_C(12436184717236109307),
            UINT64_C(3962172157175319849),
            UINT64_C(7381016538464732718),
            UINT64_C(1011752739694698287),
        },
        {
            UINT64_C(1997599621687373223),
            UINT64_C(6052339484930628067),
            UINT64_C(10108755138030829701),
            UINT64_C(150537098327114917),
        },
    };
};

using Elem_BN128 = Elem<Tag_BN128>;

} // namespace fi
