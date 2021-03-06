PROJECT = elvis

DEPS = lager sync getopt jiffy ibrowse aleppo zipper egithub
TEST_DEPS = meck

dep_lager = git https://github.com/basho/lager.git 2.0.3
dep_sync = git https://github.com/rustyio/sync.git master
dep_getopt = git https://github.com/jcomellas/getopt v0.8.2
dep_meck = git https://github.com/eproxus/meck 0.8.2
dep_jiffy = git https://github.com/davisp/jiffy 0.11.3
dep_ibrowse = git https://github.com/cmullaparthi/ibrowse v4.1.1
dep_aleppo = git https://github.com/inaka/aleppo 0.9.0
dep_zipper = git https://github.com/inaka/zipper 0.1.0
dep_egithub = git https://github.com/inaka/erlang-github 0.1.0

include erlang.mk

ERLC_OPTS += +'{parse_transform, lager_transform}'
ERLC_OPTS += +warn_unused_vars +warn_export_all +warn_shadow_vars +warn_unused_import +warn_unused_function
ERLC_OPTS += +warn_bif_clash +warn_unused_record +warn_deprecated_function +warn_obsolete_guard +strict_validation
ERLC_OPTS += +warn_export_vars +warn_exported_vars +warn_missing_spec +warn_untyped_record +debug_info

# Commont Test Config

TEST_ERLC_OPTS += +'{parse_transform, lager_transform}'
CT_SUITES = elvis style project git
CT_OPTS = -cover test/elvis.coverspec  -erl_args -config config/test.config

# Builds the elvis escript.
escript: all
	rebar escriptize
	./elvis help

shell: app
	erl -pa ebin -pa deps/*/ebin -s sync -s elvis -s lager -config config/elvis.config

test-shell: app
	erl -pa ebin -pa deps/*/ebin -pa test -s sync -s elvis -s lager -config config/elvis.config
