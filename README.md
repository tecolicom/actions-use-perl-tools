# actions-use-perl-tools

![actions-use-perl-tools](https://github.com/tecolicom/actions-use-perl-tools/actions/workflows/test.yml/badge.svg)


This GitHub action installs CPAN tools and cache it for later use.
When executed next time with same module list, and any other
environment, such as os and perl version, are not changed, installed
tools are extracted from the cached archive.

Output is same as [`@actions/cache`](https://github.com/actions/cache).

Modules installation is done even if the cache was found.  So if the
newer version is available, it is installed and cached for next use.

## Usage

```yaml
# inputs:
#   tools:   { required: true,  type: string }
#   cache:   { required: false, type: string, default: yes }
#   key:     { required: false, type: string }
#   sudo:    { required: false, type: boolean, default: false }
#   verbose: { required: false, type: boolean, default: false }

- uses: tecolicom/actions-use-perl-tools@v1
  with:

    # CPAN tools
    tools: ''

    # Cache strategy
    #
    # yes:      activate cache
    # no:       no cache
    # workflow: effective within same workflow (mainly for test)
    #
    cache: yes

    # Additional cache key
    key: ''

    # Install by root
    #
    # Default: false
    sudo: false

    # Verbose output
    verbose: false
```

## Side effects

- `~/perl5/bin` is appended to `$GITHUB_PATH` file.
- `PERL_MB_OPT`, `PERL_MM_OPT`, `PERL5LIB`, `PERL_LOCAL_LIB_ROOT`
  environment variables may be set in `$GITHUB_ENV` file.

## Senarios

- [normal usage](#normal-usage)
- [no cache](#no-cache)
- [additional cache key](#additional-cache-key)

### normal usage

```yaml
- uses: tecolicom/actions-use-perl-tools@v1
  with:
    tools: App::Greple App::optex::textconv App::sdif
```

```yaml
- uses: tecolicom/actions-use-perl-tools@v1
  with:
    tools: >-
      App::Greple
      App::optex::textconv
      App::sdif
```

### no cache

```yaml
- uses: tecolicom/actions-use-perl-tools@v1
  with:
    cache: no
    tools: App::Greple App::optex::textconv App::sdif
```

### additional cache key

```yaml
- uses: tecolicom/actions-use-perl-tools@v1
  with:
    key: v2
    tools: App::Greple App::optex::textconv App::sdif
```

## See Also

### [tecolicom/actions](https://github.com/tecolicom/actions)
