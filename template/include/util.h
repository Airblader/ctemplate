// vim:ts=4:sw=4:expandtab
#pragma once

#define FREE(p)   \
    do {          \
        free(p);  \
        p = NULL; \
    } while (0)
