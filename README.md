# actions-use-perl-modules

This Github action isntall CPAN modules in `~/perl5` directory and
cache it for later use.  When executed next time with same module
list, and any other environment, such as os and perl version, are not
changed, installed modules are extracted from the cached archive.

## usage

```
# inputs:
#   modules:      { required: true,  type: string }
#   install_base: { required: false, type: string }
#   cache:        { required: false, type: string, default: yes }
#   cache_gen:    { required: false, type: string, default: v1 }

- uses: office-tecoli/actions-use-perl-modules@v0
  with:

    # CPAN modules
    modules: ''

    # INSTALL_BASE directory
    #
    # Default: ~/perl5
    install_base: ''

    # Cache strategey
    #
    # yes:      activate cache
    # workflow: effective within same workflow (mainly for test)
    #
    # anything else means 'no'
    cache: yes

    #
    # Cache generation.
    # You can set any string to this parameter and different generation
    # number produces different cache key.
    #
    # Default: v1
    cache_gen: 'v1'

```

## Side effects

- `~/perl5/bin` is appended to `$GITHUB_PATH` file.
- `PERL_MB_OPT`, `PERL_MM_OPT`, `PERL5LIB`, `PERL_LOCAL_LIB_ROOT`
  environment variables are set in `$GITHUB_ENV` file.

## Senarios

- [normal usage](#normal-usage)
- [no cache](#no-cache)
- [cache generation](#cache-generation)
- [specify istall directory](#specify-istall-directory)

### normal usage

```yml
- uses: office-tecoli/actions-use-perl-modules@v0
  with:
    modules: App::Greple App::optex::textconv App::sdif
```

### no cache

```yml
- uses: office-tecoli/actions-use-perl-modules@v0
  with:
    cache: no
    modules: App::Greple App::optex::textconv App::sdif
```

### cache generation

```yml
- uses: office-tecoli/actions-use-perl-modules@v0
  with:
    cache_gen: v2
    modules: App::Greple App::optex::textconv App::sdif
```

### specify istall directory

If the directory start with /, it is taken as a full path.  If not, it
is considered as relative from home directory.

```yml
- uses: office-tecoli/actions-use-perl-modules@v0
  with:
    install_base: perl
    modules: App::Greple App::optex::textconv App::sdif
```
