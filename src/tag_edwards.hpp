#pragma once

#include <stdint.h>
#include "field_traits_3.hpp"
#include "field.hpp"
#include "elem.hpp"

namespace fi
{

struct Tag_Edwards
{
    enum { W = 3 };

    static inline const Field<W> field = {
        {
            UINT64_C(2154219425882963969),
            UINT64_C(14187153099288613580),
            UINT64_C(4562419863686742),
        },
        {
            UINT64_C(9807298708359238893),
            UINT64_C(17745509016751113664),
            UINT64_C(3560293536081228582),
            UINT64_C(4043),
        },
        {
            UINT64_C(15989277481165127679),
            UINT64_C(4945467343582031795),
            UINT64_C(6747544018937591251),
        },
        {
            UINT64_C(15800808019794587701),
            UINT64_C(10714088812840821347),
            UINT64_C(880564824050600),
        },
        {
            UINT64_C(8093399778288315155),
            UINT64_C(8357292106564177181),
            UINT64_C(1827125200326213),
        },
    };
};

using Elem_Edwards = Elem<Tag_Edwards>;

} // namespace fi
