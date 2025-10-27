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

## Git

- `UBOOT_BRANCH`
- `UBOOT_SUBDIR`
- `UBOOT_COMMIT`
- `UBOOT_GIT`
- `UBOOT_SBI_BRANCH`
- `UBOOT_SBI_GIT`

## Config

- `UBOOT_SBI_PLATFORM`
- `UBOOT_SBI_MAKE_ARGS`
- `UBOOT_DEFCONFIGS`

## SBI

- `UBOOT_SBI`
- `UBOOT_SBI_BRANCH`

## Result Files

- `UBOOT_RESULT_FILENAMES`
- `UBOOT_SBI_RESULT_FILENAMES`

## Override Functions

```
function override_functionname() {
        . $1
        # Custom actions...
}
```
