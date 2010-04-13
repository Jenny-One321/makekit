#!/bin/sh

. "${MK_HOME}/mk.sh" || exit 1
mk_import

_mk_args

_stamp="$1"
shift

MK_LOG_DOMAIN="configure"

mk_log "$SOURCEDIR"

_mk_try mkdir -p "${MK_OBJECT_DIR}${MK_SUBDIR}/${SOURCEDIR}"
_mk_try mkdir -p "${MK_STAGE_DIR}"

_src_dir="`cd ${MK_SOURCE_DIR}${MK_SUBDIR}/${SOURCEDIR} && pwd`"
_stage_dir="`cd ${MK_STAGE_DIR} && pwd`"
_include_dir="${_stage_dir}${MK_INCLUDE_DIR}"
_lib_dir="${_stage_dir}${MK_LIB_DIR}"

cd "${MK_OBJECT_DIR}${MK_SUBDIR}/${SOURCEDIR}" && \
_mk_try "${_src_dir}/configure" \
    CPPFLAGS="-I${_include_dir} $CPPFLAGS" \
    CFLAGS="$CFLAGS" \
    LDFLAGS="-L${_lib_dir} $LDFLAGS" \
    --prefix="${MK_PREFIX_DIR}" \
    --libdir="${MK_LIB_DIR}" \
    --bindir="${MK_BIN_DIR}" \
    "$@"
cd "${MK_ROOT_DIR}" && _mk_try touch "$_stamp"
