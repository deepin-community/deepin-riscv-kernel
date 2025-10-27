# Kernel Config

## Dependency

- `PKG_DEPS`: extra packages to install

## Toolchain

- `GCC_VER`: gcc version to use
  - default: 12
- `GCC_ARCH`: gcc arch
  - default: riscv64
- `CROSS_COMPILE`: replace cross compile env
  - default: ${GCC_ARCH}-linux-gnu-
- `NOCCACHE`: ccache is not used
  - default: (unset)

## Git

- `KERNEL_BRANCH`
- `KERNEL_SUBDIR`
- `KERNEL_COMMIT`
- `KERNEL_GIT`

## Config

- `KERNEL_DEFCONFIG`: default config
  - default: defconfig
- `KERNEL_DEFCONFIG_USE`: use external config as defconfig
  - default: (unset)
- `KERNEL_CONFIGS_FROM_DEBIAN`: use debian config as defconfig
  - default: (unset)
- `KERNEL_EXTRA_CONFIGS`: use external config as appended config
  - default: (unset)
- `KERNEL_ENABLE_MODULES`: enable modules support (requires native build)
  - default: (unset)
- `KERNEL_ENABLE_DEBUG`: enable debug (dbg deb may be huge)
  - default: (unset)

## Version

- `KERNEL_BUILD_VERSION`: override build version
  - default: (unset)

## Patches

- `KERNEL_PATCHES`
- `KERNEL_PATCHES_PROPRIETARY`

## Override Functions

```
function override_functionname() {
        . $1
        # Custom actions...
}
```
