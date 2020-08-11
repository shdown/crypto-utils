#pragma once

#include <stdint.h>
#include "field_traits_5.hpp"
#include "field.hpp"
#include "elem.hpp"

namespace fi
{

struct Tag_MNT6
{
    enum { W = 5 };

    static inline const Field<W> field = {
        {
            UINT64_C(14487189785281953793),
            UINT64_C(4731562877756902930),
            UINT64_C(14622846468719063274),
            UINT64_C(11702080941310629006),
            UINT64_C(4110145082483),
        },
        {
            UINT64_C(11610527751360753120),
            UINT64_C(1134033391035539201),
            UINT64_C(4914819162615448286),
            UINT64_C(15933880299953654537),
            UINT64_C(8657612014671762861),
            UINT64_C(4488100),
        },
        {
            UINT64_C(12714121028002250751),
            UINT64_C(15815486862325306547),
            UINT64_C(3801242257516899097),
            UINT64_C(3966675049996419374),
            UINT64_C(11702746876738633864),
        },
        {
            UINT64_C(1784298994435064924),
            UINT64_C(16852041090100268533),
            UINT64_C(14258261760832875328),
            UINT64_C(2961187778261111191),
            UINT64_C(1929014752195),
        },
        {
            UINT64_C(28619103704175136),
            UINT64_C(11702218449377544339),
            UINT64_C(7403203599591297249),
            UINT64_C(2248105543421449339),
            UINT64_C(2357678148148),
        },
    };
};

using Elem_MNT6 = Elem<Tag_MNT6>;

} // namespace fi