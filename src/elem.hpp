#pragma once

#include <stdint.h>
#include "field.hpp"

namespace fi
{

template<class Tag>
struct Elem
{
    uint64_t limbs[Tag::W];

    Elem()
        : limbs{}
    {}

    Elem(uint64_t x)
    {
        limbs[0] = x;
        for (int i = 1; i < Tag::W; ++i)
            limbs[i] = 0;
    }

    Elem& operator +=(const Elem &that)
    {
        fi::add(limbs, that.limbs, Tag::field);
        return *this;
    }

    Elem& operator -=(const Elem &that)
    {
        fi::sub(limbs, that.limbs, Tag::field);
        return *this;
    }

    Elem operator -() const
    {
        return Elem{} - *this;
    }

    void invert()
    {
        fi::invert(limbs, Tag::field);
    }

    Elem inverse() const
    {
        Elem e = *this;
        e.invert();
        return e;
    }

    Elem& operator *=(const Elem &that)
    {
        fi::mul(limbs, that.limbs, limbs, Tag::field);
        return *this;
    }

    Elem& operator /=(const Elem &that)
    {
        return *this *= that.inverse();
    }

    Elem operator +(const Elem &that) const
    {
        Elem e = *this;
        e += that;
        return e;
    }

    Elem operator -(const Elem &that) const
    {
        Elem e = *this;
        e -= that;
        return e;
    }

    Elem operator *(const Elem &that) const
    {
        Elem e = *this;
        e *= that;
        return e;
    }

    Elem operator /(const Elem &that) const
    {
        Elem e = *this;
        e /= that;
        return e;
    }

    bool operator ==(const Elem &that) const
    {
        return static_cast<bool>(fi::Field_traits<Tag::W>::cmpeq(limbs, that.limbs));
    }

    bool operator !=(const Elem &that) const
    {
        return !(*this == that);
    }

    explicit operator bool() const
    {
        return *this != 0;
    }
};

template<class E> struct Elem_traits;

template<class Tag> struct Elem_traits<Elem<Tag>>
{
    using Tag_t = Tag;
    enum { W = Tag::W };
};

} // namespace fi
