// vim:ts=4:sw=4:expandtab
#include "all.h"
#include <getopt.h>

#ifndef __VERSION
#define __VERSION "unknown"
#endif

/* Forward declarations */
static void at_exit_cb(void);
static void parse_args(int argc, char *argv[]);
static void print_usage(void);

int main(int argc, char *argv[]) {
    atexit(at_exit_cb);
    parse_args(argc, argv);
}

static void at_exit_cb(void) {
}

static void parse_args(int argc, char *argv[]) {
    int c,
        opt_index = 0;
    static struct option long_options[] = {
        { "version", no_argument, 0, 'v' },
        { "help", no_argument, 0, 'h' },
        { 0, 0, 0, 0}
    };

    while ((c = getopt_long(argc, argv, "vh", long_options, &opt_index)) != -1) {
        switch (c) {
            case 0:
                /* Example for a long-named option.
                if (strcmp(long_options[opt_index].name, "parameter") == 0) {
                    break;
                }
                */

                print_usage();
                break;
            case 'v':
                fprintf(stderr, "PROJECT version %s\n", __VERSION);
                exit(EXIT_SUCCESS);
                break;
            case 'h':
            default:
                print_usage();
                break;
        }
    }
}

static void print_usage(void) {
    fprintf(stderr, "Usage: PROJECT [-v|--version] [-h|--help]");
    fprintf(stderr, "\n");
    exit(EXIT_FAILURE);
}
