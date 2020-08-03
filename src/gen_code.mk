#!/usr/bin/make -f

width :=
ifeq ($(width),)
$(error "Please define 'width' variable, e.g.: ./gen_code.mk width=4")
endif

all: teki_$(width).h teki_$(width).s field_traits_$(width).hpp

teki_$(width).h: gen_teki.py
	./gen_teki.py gen_c_header $(width) > teki_$(width).h

teki_$(width).s: gen_teki.py
	./gen_teki.py gen_asm $(width) > teki_$(width).s

field_traits_$(width).hpp: gen_teki.py
	./gen_teki.py gen_cxx_header $(width) > field_traits_$(width).hpp

clean:
	$(RM) teki_$(width).s teki_$(width).o teki_$(width).h field_traits_$(width).hpp

.PHONY: all clean
