savedcmd_.module-common.o := arm-linux-gnueabihf-gcc -Wp,-MMD,./..module-common.o.d  -nostdinc -I/home/uuu/linux/arch/arm/include -I/home/uuu/linux/arch/arm/include/generated -I/home/uuu/linux/include -I/home/uuu/linux/include -I/home/uuu/linux/arch/arm/include/uapi -I/home/uuu/linux/arch/arm/include/generated/uapi -I/home/uuu/linux/include/uapi -I/home/uuu/linux/include/generated/uapi -include /home/uuu/linux/include/linux/compiler-version.h -include /home/uuu/linux/include/linux/kconfig.h -include /home/uuu/linux/include/linux/compiler_types.h -D__KERNEL__ -mlittle-endian -D__LINUX_ARM_ARCH__=7 -std=gnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fno-dwarf2-cfi-asm -fno-ipa-sra -mtp=cp15 -mabi=aapcs-linux -mfpu=vfp -funwind-tables -marm -Wa,-mno-warn-deprecated -march=armv7-a -msoft-float -Uarm -fno-delete-null-pointer-checks -O2 --param=allow-store-data-races=0 -fstack-protector-strong -fomit-frame-pointer -fno-stack-clash-protection -fno-strict-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wall -Wextra -Wundef -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Werror=strict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=1024 -Wno-main -Wvla-larger-than=1 -Wno-pointer-sign -Wcast-function-type -Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-larger-than -Wimplicit-fallthrough=5 -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -Wunused -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-format-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno-override-init -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -g  -DMODULE  -DKBUILD_BASENAME='".module_common"' -DKBUILD_MODNAME='".module_common.o"' -D__KBUILD_MODNAME=kmod_.module_common.o -c -o .module-common.o /home/uuu/linux/scripts/module-common.c  

source_.module-common.o := /home/uuu/linux/scripts/module-common.c

deps_.module-common.o := \
    $(wildcard include/config/UNWINDER_ORC) \
    $(wildcard include/config/MITIGATION_RETPOLINE) \
  /home/uuu/linux/include/linux/compiler-version.h \
    $(wildcard include/config/CC_VERSION_TEXT) \
  /home/uuu/linux/include/linux/kconfig.h \
    $(wildcard include/config/CPU_BIG_ENDIAN) \
    $(wildcard include/config/BOOGER) \
    $(wildcard include/config/FOO) \
  /home/uuu/linux/include/linux/compiler_types.h \
    $(wildcard include/config/DEBUG_INFO_BTF) \
    $(wildcard include/config/PAHOLE_HAS_BTF_TAG) \
    $(wildcard include/config/FUNCTION_ALIGNMENT) \
    $(wildcard include/config/CC_HAS_SANE_FUNCTION_ALIGNMENT) \
    $(wildcard include/config/X86_64) \
    $(wildcard include/config/ARM64) \
    $(wildcard include/config/LD_DEAD_CODE_DATA_ELIMINATION) \
    $(wildcard include/config/LTO_CLANG) \
    $(wildcard include/config/HAVE_ARCH_COMPILER_H) \
    $(wildcard include/config/CC_HAS_COUNTED_BY) \
    $(wildcard include/config/CC_HAS_MULTIDIMENSIONAL_NONSTRING) \
    $(wildcard include/config/UBSAN_INTEGER_WRAP) \
    $(wildcard include/config/CC_HAS_ASM_INLINE) \
  /home/uuu/linux/include/linux/compiler_attributes.h \
  /home/uuu/linux/include/linux/compiler-gcc.h \
    $(wildcard include/config/ARCH_USE_BUILTIN_BSWAP) \
    $(wildcard include/config/SHADOW_CALL_STACK) \
    $(wildcard include/config/KCOV) \
    $(wildcard include/config/CC_HAS_TYPEOF_UNQUAL) \
  /home/uuu/linux/include/linux/module.h \
    $(wildcard include/config/MODULES) \
    $(wildcard include/config/SYSFS) \
    $(wildcard include/config/MODULES_TREE_LOOKUP) \
    $(wildcard include/config/LIVEPATCH) \
    $(wildcard include/config/STACKTRACE_BUILD_ID) \
    $(wildcard include/config/ARCH_USES_CFI_TRAPS) \
    $(wildcard include/config/MODULE_SIG) \
    $(wildcard include/config/GENERIC_BUG) \
    $(wildcard include/config/KALLSYMS) \
    $(wildcard include/config/SMP) \
    $(wildcard include/config/TRACEPOINTS) \
    $(wildcard include/config/TREE_SRCU) \
    $(wildcard include/config/BPF_EVENTS) \
    $(wildcard include/config/DEBUG_INFO_BTF_MODULES) \
    $(wildcard include/config/JUMP_LABEL) \
    $(wildcard include/config/TRACING) \
    $(wildcard include/config/EVENT_TRACING) \
    $(wildcard include/config/DYNAMIC_FTRACE) \
    $(wildcard include/config/KPROBES) \
    $(wildcard include/config/HAVE_STATIC_CALL_INLINE) \
    $(wildcard include/config/KUNIT) \
    $(wildcard include/config/PRINTK_INDEX) \
    $(wildcard include/config/MODULE_UNLOAD) \
    $(wildcard include/config/CONSTRUCTORS) \
    $(wildcard include/config/FUNCTION_ERROR_INJECTION) \
    $(wildcard include/config/DYNAMIC_DEBUG_CORE) \
  /home/uuu/linux/include/linux/list.h \
    $(wildcard include/config/LIST_HARDENED) \
    $(wildcard include/config/DEBUG_LIST) \
  /home/uuu/linux/include/linux/container_of.h \
  /home/uuu/linux/include/linux/build_bug.h \
  /home/uuu/linux/include/linux/compiler.h \
    $(wildcard include/config/TRACE_BRANCH_PROFILING) \
    $(wildcard include/config/PROFILE_ALL_BRANCHES) \
    $(wildcard include/config/OBJTOOL) \
    $(wildcard include/config/CFI_CLANG) \
    $(wildcard include/config/64BIT) \
  /home/uuu/linux/arch/arm/include/generated/asm/rwonce.h \
  /home/uuu/linux/include/asm-generic/rwonce.h \
  /home/uuu/linux/include/linux/kasan-checks.h \
    $(wildcard include/config/KASAN_GENERIC) \
    $(wildcard include/config/KASAN_SW_TAGS) \
  /home/uuu/linux/include/linux/types.h \
    $(wildcard include/config/HAVE_UID16) \
    $(wildcard include/config/UID16) \
    $(wildcard include/config/ARCH_DMA_ADDR_T_64BIT) \
    $(wildcard include/config/PHYS_ADDR_T_64BIT) \
    $(wildcard include/config/ARCH_32BIT_USTAT_F_TINODE) \
  /home/uuu/linux/include/uapi/linux/types.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/types.h \
  /home/uuu/linux/include/asm-generic/int-ll64.h \
  /home/uuu/linux/include/uapi/asm-generic/int-ll64.h \
  /home/uuu/linux/arch/arm/include/generated/uapi/asm/bitsperlong.h \
  /home/uuu/linux/include/asm-generic/bitsperlong.h \
  /home/uuu/linux/include/uapi/asm-generic/bitsperlong.h \
  /home/uuu/linux/include/uapi/linux/posix_types.h \
  /home/uuu/linux/include/linux/stddef.h \
  /home/uuu/linux/include/uapi/linux/stddef.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/posix_types.h \
  /home/uuu/linux/include/uapi/asm-generic/posix_types.h \
  /home/uuu/linux/include/linux/kcsan-checks.h \
    $(wildcard include/config/KCSAN) \
    $(wildcard include/config/KCSAN_WEAK_MEMORY) \
    $(wildcard include/config/KCSAN_IGNORE_ATOMICS) \
  /home/uuu/linux/include/linux/poison.h \
    $(wildcard include/config/ILLEGAL_POINTER_VALUE) \
  /home/uuu/linux/include/linux/const.h \
  /home/uuu/linux/include/vdso/const.h \
  /home/uuu/linux/include/uapi/linux/const.h \
  /home/uuu/linux/arch/arm/include/asm/barrier.h \
    $(wildcard include/config/CPU_32v6K) \
    $(wildcard include/config/THUMB2_KERNEL) \
    $(wildcard include/config/CPU_XSC3) \
    $(wildcard include/config/CPU_FA526) \
    $(wildcard include/config/ARM_HEAVY_MB) \
    $(wildcard include/config/ARM_DMA_MEM_BUFFERABLE) \
    $(wildcard include/config/CPU_SPECTRE) \
  /home/uuu/linux/include/asm-generic/barrier.h \
  /home/uuu/linux/include/linux/stat.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/stat.h \
  /home/uuu/linux/include/uapi/linux/stat.h \
  /home/uuu/linux/include/linux/time.h \
    $(wildcard include/config/POSIX_TIMERS) \
  /home/uuu/linux/include/linux/cache.h \
    $(wildcard include/config/ARCH_HAS_CACHE_LINE_SIZE) \
  /home/uuu/linux/include/uapi/linux/kernel.h \
  /home/uuu/linux/include/uapi/linux/sysinfo.h \
  /home/uuu/linux/include/vdso/cache.h \
  /home/uuu/linux/arch/arm/include/asm/cache.h \
    $(wildcard include/config/ARM_L1_CACHE_SHIFT) \
    $(wildcard include/config/AEABI) \
  /home/uuu/linux/include/linux/math64.h \
    $(wildcard include/config/ARCH_SUPPORTS_INT128) \
  /home/uuu/linux/include/linux/math.h \
  /home/uuu/linux/arch/arm/include/asm/div64.h \
    $(wildcard include/config/CC_OPTIMIZE_FOR_PERFORMANCE) \
  /home/uuu/linux/arch/arm/include/asm/compiler.h \
  /home/uuu/linux/include/asm-generic/div64.h \
  /home/uuu/linux/include/linux/log2.h \
    $(wildcard include/config/ARCH_HAS_ILOG2_U32) \
    $(wildcard include/config/ARCH_HAS_ILOG2_U64) \
  /home/uuu/linux/include/linux/bitops.h \
  /home/uuu/linux/include/linux/bits.h \
  /home/uuu/linux/include/vdso/bits.h \
  /home/uuu/linux/include/uapi/linux/bits.h \
  /home/uuu/linux/include/linux/overflow.h \
  /home/uuu/linux/include/linux/limits.h \
  /home/uuu/linux/include/uapi/linux/limits.h \
  /home/uuu/linux/include/vdso/limits.h \
  /home/uuu/linux/include/linux/typecheck.h \
  /home/uuu/linux/include/asm-generic/bitops/generic-non-atomic.h \
  /home/uuu/linux/arch/arm/include/asm/bitops.h \
  /home/uuu/linux/include/linux/irqflags.h \
    $(wildcard include/config/PROVE_LOCKING) \
    $(wildcard include/config/TRACE_IRQFLAGS) \
    $(wildcard include/config/PREEMPT_RT) \
    $(wildcard include/config/IRQSOFF_TRACER) \
    $(wildcard include/config/PREEMPT_TRACER) \
    $(wildcard include/config/DEBUG_IRQFLAGS) \
    $(wildcard include/config/TRACE_IRQFLAGS_SUPPORT) \
  /home/uuu/linux/include/linux/irqflags_types.h \
  /home/uuu/linux/include/linux/cleanup.h \
  /home/uuu/linux/include/linux/err.h \
  /home/uuu/linux/arch/arm/include/generated/uapi/asm/errno.h \
  /home/uuu/linux/include/uapi/asm-generic/errno.h \
  /home/uuu/linux/include/uapi/asm-generic/errno-base.h \
  /home/uuu/linux/include/linux/args.h \
  /home/uuu/linux/arch/arm/include/asm/irqflags.h \
    $(wildcard include/config/CPU_V7M) \
  /home/uuu/linux/arch/arm/include/asm/ptrace.h \
    $(wildcard include/config/ARM_THUMB) \
  /home/uuu/linux/arch/arm/include/uapi/asm/ptrace.h \
    $(wildcard include/config/CPU_ENDIAN_BE8) \
  /home/uuu/linux/arch/arm/include/asm/hwcap.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/hwcap.h \
  /home/uuu/linux/include/linux/bitfield.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/byteorder.h \
  /home/uuu/linux/include/linux/byteorder/little_endian.h \
  /home/uuu/linux/include/uapi/linux/byteorder/little_endian.h \
  /home/uuu/linux/include/linux/swab.h \
  /home/uuu/linux/include/uapi/linux/swab.h \
  /home/uuu/linux/arch/arm/include/asm/swab.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/swab.h \
  /home/uuu/linux/include/linux/byteorder/generic.h \
  /home/uuu/linux/include/asm-generic/irqflags.h \
  /home/uuu/linux/arch/arm/include/asm/percpu.h \
    $(wildcard include/config/CPU_V6) \
    $(wildcard include/config/ARM_HAS_GROUP_RELOCS) \
    $(wildcard include/config/ARM_MODULE_PLTS) \
  /home/uuu/linux/arch/arm/include/asm/insn.h \
  /home/uuu/linux/include/asm-generic/percpu.h \
    $(wildcard include/config/DEBUG_PREEMPT) \
    $(wildcard include/config/HAVE_SETUP_PER_CPU_AREA) \
  /home/uuu/linux/include/linux/threads.h \
    $(wildcard include/config/NR_CPUS) \
    $(wildcard include/config/BASE_SMALL) \
  /home/uuu/linux/include/linux/percpu-defs.h \
    $(wildcard include/config/ARCH_MODULE_NEEDS_WEAK_PER_CPU) \
    $(wildcard include/config/DEBUG_FORCE_WEAK_PER_CPU) \
    $(wildcard include/config/AMD_MEM_ENCRYPT) \
  /home/uuu/linux/include/asm-generic/bitops/non-atomic.h \
  /home/uuu/linux/include/asm-generic/bitops/non-instrumented-non-atomic.h \
  /home/uuu/linux/include/asm-generic/bitops/builtin-__fls.h \
  /home/uuu/linux/include/asm-generic/bitops/builtin-__ffs.h \
  /home/uuu/linux/include/asm-generic/bitops/builtin-fls.h \
  /home/uuu/linux/include/asm-generic/bitops/builtin-ffs.h \
  /home/uuu/linux/include/asm-generic/bitops/ffz.h \
  /home/uuu/linux/include/asm-generic/bitops/fls64.h \
  /home/uuu/linux/include/asm-generic/bitops/sched.h \
  /home/uuu/linux/include/asm-generic/bitops/hweight.h \
  /home/uuu/linux/include/asm-generic/bitops/arch_hweight.h \
  /home/uuu/linux/include/asm-generic/bitops/const_hweight.h \
  /home/uuu/linux/include/asm-generic/bitops/lock.h \
  /home/uuu/linux/include/linux/atomic.h \
  /home/uuu/linux/arch/arm/include/asm/atomic.h \
    $(wildcard include/config/GENERIC_ATOMIC64) \
    $(wildcard include/config/ARM_LPAE) \
  /home/uuu/linux/include/linux/prefetch.h \
  /home/uuu/linux/arch/arm/include/asm/processor.h \
    $(wildcard include/config/HAVE_HW_BREAKPOINT) \
    $(wildcard include/config/BINFMT_ELF_FDPIC) \
    $(wildcard include/config/MMU) \
  /home/uuu/linux/arch/arm/include/asm/hw_breakpoint.h \
  /home/uuu/linux/arch/arm/include/asm/unified.h \
  /home/uuu/linux/arch/arm/include/asm/vdso/processor.h \
    $(wildcard include/config/ARM_ERRATA_754327) \
  /home/uuu/linux/arch/arm/include/asm/cmpxchg.h \
    $(wildcard include/config/CPU_SA1100) \
    $(wildcard include/config/CPU_SA110) \
  /home/uuu/linux/include/linux/cmpxchg-emu.h \
  /home/uuu/linux/include/asm-generic/cmpxchg-local.h \
  /home/uuu/linux/include/linux/atomic/atomic-arch-fallback.h \
  /home/uuu/linux/include/linux/atomic/atomic-long.h \
  /home/uuu/linux/include/linux/atomic/atomic-instrumented.h \
  /home/uuu/linux/include/linux/instrumented.h \
  /home/uuu/linux/include/linux/kmsan-checks.h \
    $(wildcard include/config/KMSAN) \
  /home/uuu/linux/include/asm-generic/bitops/instrumented-lock.h \
  /home/uuu/linux/include/asm-generic/bitops/le.h \
  /home/uuu/linux/include/asm-generic/bitops/ext2-atomic-setbit.h \
  /home/uuu/linux/include/vdso/math64.h \
  /home/uuu/linux/include/linux/time64.h \
  /home/uuu/linux/include/vdso/time64.h \
  /home/uuu/linux/include/uapi/linux/time.h \
  /home/uuu/linux/include/uapi/linux/time_types.h \
  /home/uuu/linux/include/linux/time32.h \
  /home/uuu/linux/include/linux/timex.h \
  /home/uuu/linux/include/uapi/linux/timex.h \
  /home/uuu/linux/include/uapi/linux/param.h \
  /home/uuu/linux/arch/arm/include/generated/uapi/asm/param.h \
  /home/uuu/linux/include/asm-generic/param.h \
    $(wildcard include/config/HZ) \
  /home/uuu/linux/include/uapi/asm-generic/param.h \
  /home/uuu/linux/arch/arm/include/asm/timex.h \
  /home/uuu/linux/include/vdso/time32.h \
  /home/uuu/linux/include/vdso/time.h \
  /home/uuu/linux/include/linux/uidgid.h \
    $(wildcard include/config/MULTIUSER) \
    $(wildcard include/config/USER_NS) \
  /home/uuu/linux/include/linux/uidgid_types.h \
  /home/uuu/linux/include/linux/highuid.h \
  /home/uuu/linux/include/linux/buildid.h \
    $(wildcard include/config/VMCORE_INFO) \
  /home/uuu/linux/include/linux/kmod.h \
  /home/uuu/linux/include/linux/umh.h \
  /home/uuu/linux/include/linux/gfp.h \
    $(wildcard include/config/HIGHMEM) \
    $(wildcard include/config/ZONE_DMA) \
    $(wildcard include/config/ZONE_DMA32) \
    $(wildcard include/config/ZONE_DEVICE) \
    $(wildcard include/config/NUMA) \
    $(wildcard include/config/COMPACTION) \
    $(wildcard include/config/CONTIG_ALLOC) \
  /home/uuu/linux/include/linux/gfp_types.h \
    $(wildcard include/config/KASAN_HW_TAGS) \
    $(wildcard include/config/LOCKDEP) \
    $(wildcard include/config/SLAB_OBJ_EXT) \
  /home/uuu/linux/include/linux/mmzone.h \
    $(wildcard include/config/ARCH_FORCE_MAX_ORDER) \
    $(wildcard include/config/PAGE_BLOCK_MAX_ORDER) \
    $(wildcard include/config/CMA) \
    $(wildcard include/config/MEMORY_ISOLATION) \
    $(wildcard include/config/ZSMALLOC) \
    $(wildcard include/config/UNACCEPTED_MEMORY) \
    $(wildcard include/config/IOMMU_SUPPORT) \
    $(wildcard include/config/SWAP) \
    $(wildcard include/config/NUMA_BALANCING) \
    $(wildcard include/config/HUGETLB_PAGE) \
    $(wildcard include/config/TRANSPARENT_HUGEPAGE) \
    $(wildcard include/config/LRU_GEN) \
    $(wildcard include/config/LRU_GEN_STATS) \
    $(wildcard include/config/LRU_GEN_WALKS_MMU) \
    $(wildcard include/config/MEMCG) \
    $(wildcard include/config/SPARSEMEM) \
    $(wildcard include/config/MEMORY_HOTPLUG) \
    $(wildcard include/config/MEMORY_FAILURE) \
    $(wildcard include/config/FLATMEM) \
    $(wildcard include/config/PAGE_EXTENSION) \
    $(wildcard include/config/DEFERRED_STRUCT_PAGE_INIT) \
    $(wildcard include/config/HAVE_MEMORYLESS_NODES) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP) \
    $(wildcard include/config/SPARSEMEM_EXTREME) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP_PREINIT) \
    $(wildcard include/config/HAVE_ARCH_PFN_VALID) \
  /home/uuu/linux/include/linux/spinlock.h \
    $(wildcard include/config/DEBUG_SPINLOCK) \
    $(wildcard include/config/PREEMPTION) \
    $(wildcard include/config/DEBUG_LOCK_ALLOC) \
  /home/uuu/linux/include/linux/preempt.h \
    $(wildcard include/config/PREEMPT_COUNT) \
    $(wildcard include/config/TRACE_PREEMPT_TOGGLE) \
    $(wildcard include/config/PREEMPT_NOTIFIERS) \
    $(wildcard include/config/PREEMPT_DYNAMIC) \
    $(wildcard include/config/PREEMPT_NONE) \
    $(wildcard include/config/PREEMPT_VOLUNTARY) \
    $(wildcard include/config/PREEMPT) \
    $(wildcard include/config/PREEMPT_LAZY) \
  /home/uuu/linux/include/linux/linkage.h \
    $(wildcard include/config/ARCH_USE_SYM_ANNOTATIONS) \
  /home/uuu/linux/include/linux/stringify.h \
  /home/uuu/linux/include/linux/export.h \
    $(wildcard include/config/MODVERSIONS) \
    $(wildcard include/config/GENDWARFKSYMS) \
  /home/uuu/linux/arch/arm/include/asm/linkage.h \
  /home/uuu/linux/arch/arm/include/generated/asm/preempt.h \
  /home/uuu/linux/include/asm-generic/preempt.h \
    $(wildcard include/config/HAVE_PREEMPT_DYNAMIC_KEY) \
  /home/uuu/linux/include/linux/thread_info.h \
    $(wildcard include/config/THREAD_INFO_IN_TASK) \
    $(wildcard include/config/GENERIC_ENTRY) \
    $(wildcard include/config/ARCH_HAS_PREEMPT_LAZY) \
    $(wildcard include/config/HAVE_ARCH_WITHIN_STACK_FRAMES) \
    $(wildcard include/config/SH) \
  /home/uuu/linux/include/linux/bug.h \
    $(wildcard include/config/PRINTK) \
    $(wildcard include/config/BUG_ON_DATA_CORRUPTION) \
  /home/uuu/linux/arch/arm/include/asm/bug.h \
    $(wildcard include/config/DEBUG_BUGVERBOSE) \
  /home/uuu/linux/arch/arm/include/asm/opcodes.h \
    $(wildcard include/config/CPU_ENDIAN_BE32) \
  /home/uuu/linux/include/asm-generic/bug.h \
    $(wildcard include/config/BUG) \
    $(wildcard include/config/GENERIC_BUG_RELATIVE_POINTERS) \
  /home/uuu/linux/include/linux/instrumentation.h \
    $(wildcard include/config/NOINSTR_VALIDATION) \
  /home/uuu/linux/include/linux/once_lite.h \
  /home/uuu/linux/include/linux/panic.h \
    $(wildcard include/config/PANIC_TIMEOUT) \
  /home/uuu/linux/include/linux/stdarg.h \
  /home/uuu/linux/include/linux/printk.h \
    $(wildcard include/config/MESSAGE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_QUIET) \
    $(wildcard include/config/EARLY_PRINTK) \
    $(wildcard include/config/DYNAMIC_DEBUG) \
  /home/uuu/linux/include/linux/init.h \
    $(wildcard include/config/HAVE_ARCH_PREL32_RELOCATIONS) \
  /home/uuu/linux/include/linux/kern_levels.h \
  /home/uuu/linux/include/linux/ratelimit_types.h \
  /home/uuu/linux/include/linux/spinlock_types_raw.h \
  /home/uuu/linux/arch/arm/include/asm/spinlock_types.h \
  /home/uuu/linux/include/linux/lockdep_types.h \
    $(wildcard include/config/PROVE_RAW_LOCK_NESTING) \
    $(wildcard include/config/LOCK_STAT) \
  /home/uuu/linux/include/linux/restart_block.h \
  /home/uuu/linux/include/linux/errno.h \
  /home/uuu/linux/include/uapi/linux/errno.h \
  /home/uuu/linux/arch/arm/include/asm/current.h \
    $(wildcard include/config/CURRENT_POINTER_IN_TPIDRURO) \
  /home/uuu/linux/arch/arm/include/asm/thread_info.h \
    $(wildcard include/config/KASAN) \
    $(wildcard include/config/VMAP_STACK) \
    $(wildcard include/config/ARM_THUMBEE) \
  /home/uuu/linux/arch/arm/include/asm/fpstate.h \
    $(wildcard include/config/VFPv3) \
    $(wildcard include/config/IWMMXT) \
  /home/uuu/linux/arch/arm/include/asm/page.h \
    $(wildcard include/config/CPU_COPY_V4WT) \
    $(wildcard include/config/CPU_COPY_V4WB) \
    $(wildcard include/config/CPU_COPY_FEROCEON) \
    $(wildcard include/config/CPU_COPY_FA) \
    $(wildcard include/config/CPU_XSCALE) \
    $(wildcard include/config/CPU_COPY_V6) \
    $(wildcard include/config/KUSER_HELPERS) \
  /home/uuu/linux/include/vdso/page.h \
    $(wildcard include/config/PAGE_SHIFT) \
  /home/uuu/linux/arch/arm/include/asm/glue.h \
  /home/uuu/linux/arch/arm/include/asm/pgtable-2level-types.h \
  /home/uuu/linux/arch/arm/include/asm/memory.h \
    $(wildcard include/config/NEED_MACH_MEMORY_H) \
    $(wildcard include/config/PAGE_OFFSET) \
    $(wildcard include/config/DRAM_BASE) \
    $(wildcard include/config/DRAM_SIZE) \
    $(wildcard include/config/XIP_KERNEL) \
    $(wildcard include/config/HAVE_TCM) \
    $(wildcard include/config/ARM_PATCH_PHYS_VIRT) \
    $(wildcard include/config/PHYS_OFFSET) \
    $(wildcard include/config/DEBUG_VIRTUAL) \
  /home/uuu/linux/include/linux/sizes.h \
  /home/uuu/linux/arch/arm/include/asm/kasan_def.h \
    $(wildcard include/config/KASAN_SHADOW_OFFSET) \
  /home/uuu/linux/include/asm-generic/getorder.h \
  /home/uuu/linux/include/asm-generic/memory_model.h \
  /home/uuu/linux/include/linux/pfn.h \
  /home/uuu/linux/arch/arm/include/asm/traps.h \
  /home/uuu/linux/include/linux/bottom_half.h \
  /home/uuu/linux/include/linux/instruction_pointer.h \
  /home/uuu/linux/include/linux/lockdep.h \
    $(wildcard include/config/DEBUG_LOCKING_API_SELFTESTS) \
  /home/uuu/linux/include/linux/smp.h \
    $(wildcard include/config/UP_LATE_INIT) \
    $(wildcard include/config/CSD_LOCK_WAIT_DEBUG) \
  /home/uuu/linux/include/linux/cpumask.h \
    $(wildcard include/config/FORCE_NR_CPUS) \
    $(wildcard include/config/HOTPLUG_CPU) \
    $(wildcard include/config/DEBUG_PER_CPU_MAPS) \
    $(wildcard include/config/CPUMASK_OFFSTACK) \
  /home/uuu/linux/include/linux/kernel.h \
    $(wildcard include/config/PREEMPT_VOLUNTARY_BUILD) \
    $(wildcard include/config/HAVE_PREEMPT_DYNAMIC_CALL) \
    $(wildcard include/config/PREEMPT_) \
    $(wildcard include/config/DEBUG_ATOMIC_SLEEP) \
  /home/uuu/linux/include/linux/align.h \
  /home/uuu/linux/include/vdso/align.h \
  /home/uuu/linux/include/linux/array_size.h \
  /home/uuu/linux/include/linux/hex.h \
  /home/uuu/linux/include/linux/kstrtox.h \
  /home/uuu/linux/include/linux/minmax.h \
  /home/uuu/linux/include/linux/sprintf.h \
  /home/uuu/linux/include/linux/static_call_types.h \
    $(wildcard include/config/HAVE_STATIC_CALL) \
  /home/uuu/linux/include/linux/util_macros.h \
    $(wildcard include/config/FOO_SUSPEND) \
  /home/uuu/linux/include/linux/wordpart.h \
  /home/uuu/linux/include/linux/bitmap.h \
  /home/uuu/linux/include/linux/find.h \
  /home/uuu/linux/include/linux/string.h \
    $(wildcard include/config/BINARY_PRINTF) \
    $(wildcard include/config/FORTIFY_SOURCE) \
  /home/uuu/linux/include/uapi/linux/string.h \
  /home/uuu/linux/arch/arm/include/asm/string.h \
  /home/uuu/linux/include/linux/bitmap-str.h \
  /home/uuu/linux/include/linux/cpumask_types.h \
  /home/uuu/linux/include/linux/numa.h \
    $(wildcard include/config/NUMA_KEEP_MEMINFO) \
    $(wildcard include/config/HAVE_ARCH_NODE_DEV_GROUP) \
  /home/uuu/linux/include/linux/nodemask.h \
  /home/uuu/linux/include/linux/nodemask_types.h \
    $(wildcard include/config/NODES_SHIFT) \
  /home/uuu/linux/include/linux/random.h \
    $(wildcard include/config/VMGENID) \
  /home/uuu/linux/include/uapi/linux/random.h \
  /home/uuu/linux/include/uapi/linux/ioctl.h \
  /home/uuu/linux/arch/arm/include/generated/uapi/asm/ioctl.h \
  /home/uuu/linux/include/asm-generic/ioctl.h \
  /home/uuu/linux/include/uapi/asm-generic/ioctl.h \
  /home/uuu/linux/include/linux/irqnr.h \
  /home/uuu/linux/include/uapi/linux/irqnr.h \
  /home/uuu/linux/include/linux/smp_types.h \
  /home/uuu/linux/include/linux/llist.h \
    $(wildcard include/config/ARCH_HAVE_NMI_SAFE_CMPXCHG) \
  /home/uuu/linux/arch/arm/include/asm/smp.h \
  /home/uuu/linux/arch/arm/include/generated/asm/mmiowb.h \
  /home/uuu/linux/include/asm-generic/mmiowb.h \
    $(wildcard include/config/MMIOWB) \
  /home/uuu/linux/include/linux/spinlock_types.h \
  /home/uuu/linux/include/linux/rwlock_types.h \
  /home/uuu/linux/arch/arm/include/asm/spinlock.h \
  /home/uuu/linux/include/linux/rwlock.h \
  /home/uuu/linux/include/linux/spinlock_api_smp.h \
    $(wildcard include/config/INLINE_SPIN_LOCK) \
    $(wildcard include/config/INLINE_SPIN_LOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK_BH) \
    $(wildcard include/config/UNINLINE_SPIN_UNLOCK) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/GENERIC_LOCKBREAK) \
  /home/uuu/linux/include/linux/rwlock_api_smp.h \
    $(wildcard include/config/INLINE_READ_LOCK) \
    $(wildcard include/config/INLINE_WRITE_LOCK) \
    $(wildcard include/config/INLINE_READ_LOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_LOCK_BH) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_READ_TRYLOCK) \
    $(wildcard include/config/INLINE_WRITE_TRYLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_BH) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQRESTORE) \
  /home/uuu/linux/include/linux/list_nulls.h \
  /home/uuu/linux/include/linux/wait.h \
  /home/uuu/linux/include/linux/seqlock.h \
  /home/uuu/linux/include/linux/mutex.h \
    $(wildcard include/config/DEBUG_MUTEXES) \
  /home/uuu/linux/include/linux/osq_lock.h \
  /home/uuu/linux/include/linux/debug_locks.h \
  /home/uuu/linux/include/linux/mutex_types.h \
    $(wildcard include/config/MUTEX_SPIN_ON_OWNER) \
  /home/uuu/linux/include/linux/seqlock_types.h \
  /home/uuu/linux/include/linux/pageblock-flags.h \
    $(wildcard include/config/HUGETLB_PAGE_SIZE_VARIABLE) \
  /home/uuu/linux/include/linux/page-flags-layout.h \
  /home/uuu/linux/include/generated/bounds.h \
  /home/uuu/linux/include/linux/mm_types.h \
    $(wildcard include/config/HAVE_ALIGNED_STRUCT_PAGE) \
    $(wildcard include/config/HUGETLB_PMD_PAGE_TABLE_SHARING) \
    $(wildcard include/config/SLAB_FREELIST_HARDENED) \
    $(wildcard include/config/USERFAULTFD) \
    $(wildcard include/config/ANON_VMA_NAME) \
    $(wildcard include/config/PER_VMA_LOCK) \
    $(wildcard include/config/SCHED_MM_CID) \
    $(wildcard include/config/HAVE_ARCH_COMPAT_MMAP_BASES) \
    $(wildcard include/config/MEMBARRIER) \
    $(wildcard include/config/FUTEX_PRIVATE_HASH) \
    $(wildcard include/config/AIO) \
    $(wildcard include/config/MMU_NOTIFIER) \
    $(wildcard include/config/SPLIT_PMD_PTLOCKS) \
    $(wildcard include/config/ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH) \
    $(wildcard include/config/IOMMU_MM_DATA) \
    $(wildcard include/config/KSM) \
    $(wildcard include/config/MM_ID) \
    $(wildcard include/config/CORE_DUMP_DEFAULT_ELF_HEADERS) \
  /home/uuu/linux/include/linux/mm_types_task.h \
  /home/uuu/linux/include/linux/auxvec.h \
  /home/uuu/linux/include/uapi/linux/auxvec.h \
  /home/uuu/linux/arch/arm/include/asm/auxvec.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/auxvec.h \
  /home/uuu/linux/include/linux/kref.h \
  /home/uuu/linux/include/linux/refcount.h \
  /home/uuu/linux/include/linux/refcount_types.h \
  /home/uuu/linux/include/linux/rbtree.h \
  /home/uuu/linux/include/linux/rbtree_types.h \
  /home/uuu/linux/include/linux/rcupdate.h \
    $(wildcard include/config/PREEMPT_RCU) \
    $(wildcard include/config/TINY_RCU) \
    $(wildcard include/config/RCU_STRICT_GRACE_PERIOD) \
    $(wildcard include/config/RCU_LAZY) \
    $(wildcard include/config/RCU_STALL_COMMON) \
    $(wildcard include/config/NO_HZ_FULL) \
    $(wildcard include/config/KVM_XFER_TO_GUEST_WORK) \
    $(wildcard include/config/RCU_NOCB_CPU) \
    $(wildcard include/config/TASKS_RCU_GENERIC) \
    $(wildcard include/config/TASKS_RCU) \
    $(wildcard include/config/TASKS_TRACE_RCU) \
    $(wildcard include/config/TASKS_RUDE_RCU) \
    $(wildcard include/config/TREE_RCU) \
    $(wildcard include/config/DEBUG_OBJECTS_RCU_HEAD) \
    $(wildcard include/config/PROVE_RCU) \
    $(wildcard include/config/ARCH_WEAK_RELEASE_ACQUIRE) \
  /home/uuu/linux/include/linux/context_tracking_irq.h \
    $(wildcard include/config/CONTEXT_TRACKING_IDLE) \
  /home/uuu/linux/include/linux/rcutree.h \
  /home/uuu/linux/include/linux/maple_tree.h \
    $(wildcard include/config/MAPLE_RCU_DISABLED) \
    $(wildcard include/config/DEBUG_MAPLE_TREE) \
  /home/uuu/linux/include/linux/rwsem.h \
    $(wildcard include/config/RWSEM_SPIN_ON_OWNER) \
    $(wildcard include/config/DEBUG_RWSEMS) \
    $(wildcard include/config/DETECT_HUNG_TASK_BLOCKER) \
  /home/uuu/linux/include/linux/completion.h \
  /home/uuu/linux/include/linux/swait.h \
  /home/uuu/linux/include/linux/uprobes.h \
    $(wildcard include/config/UPROBES) \
  /home/uuu/linux/include/linux/timer.h \
    $(wildcard include/config/DEBUG_OBJECTS_TIMERS) \
  /home/uuu/linux/include/linux/ktime.h \
  /home/uuu/linux/include/linux/jiffies.h \
  /home/uuu/linux/include/vdso/jiffies.h \
  /home/uuu/linux/include/generated/timeconst.h \
  /home/uuu/linux/include/vdso/ktime.h \
  /home/uuu/linux/include/linux/timekeeping.h \
    $(wildcard include/config/POSIX_AUX_CLOCKS) \
    $(wildcard include/config/GENERIC_CMOS_UPDATE) \
  /home/uuu/linux/include/linux/clocksource_ids.h \
  /home/uuu/linux/include/linux/debugobjects.h \
    $(wildcard include/config/DEBUG_OBJECTS) \
    $(wildcard include/config/DEBUG_OBJECTS_FREE) \
  /home/uuu/linux/include/linux/timer_types.h \
  /home/uuu/linux/arch/arm/include/asm/uprobes.h \
  /home/uuu/linux/arch/arm/include/asm/probes.h \
  /home/uuu/linux/include/linux/workqueue.h \
    $(wildcard include/config/DEBUG_OBJECTS_WORK) \
    $(wildcard include/config/FREEZER) \
    $(wildcard include/config/WQ_WATCHDOG) \
  /home/uuu/linux/include/linux/alloc_tag.h \
    $(wildcard include/config/MEM_ALLOC_PROFILING_DEBUG) \
    $(wildcard include/config/MEM_ALLOC_PROFILING) \
    $(wildcard include/config/MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT) \
  /home/uuu/linux/include/linux/codetag.h \
    $(wildcard include/config/CODE_TAGGING) \
  /home/uuu/linux/include/linux/static_key.h \
  /home/uuu/linux/include/linux/jump_label.h \
    $(wildcard include/config/HAVE_ARCH_JUMP_LABEL_RELATIVE) \
  /home/uuu/linux/include/linux/workqueue_types.h \
  /home/uuu/linux/include/linux/percpu_counter.h \
  /home/uuu/linux/include/linux/percpu.h \
    $(wildcard include/config/RANDOM_KMALLOC_CACHES) \
    $(wildcard include/config/PAGE_SIZE_4KB) \
    $(wildcard include/config/NEED_PER_CPU_PAGE_FIRST_CHUNK) \
  /home/uuu/linux/include/linux/mmdebug.h \
    $(wildcard include/config/DEBUG_VM) \
    $(wildcard include/config/DEBUG_VM_IRQSOFF) \
    $(wildcard include/config/DEBUG_VM_PGFLAGS) \
  /home/uuu/linux/include/linux/sched.h \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_NATIVE) \
    $(wildcard include/config/SCHED_INFO) \
    $(wildcard include/config/SCHEDSTATS) \
    $(wildcard include/config/SCHED_CORE) \
    $(wildcard include/config/FAIR_GROUP_SCHED) \
    $(wildcard include/config/RT_GROUP_SCHED) \
    $(wildcard include/config/RT_MUTEXES) \
    $(wildcard include/config/UCLAMP_TASK) \
    $(wildcard include/config/UCLAMP_BUCKETS_COUNT) \
    $(wildcard include/config/KMAP_LOCAL) \
    $(wildcard include/config/SCHED_CLASS_EXT) \
    $(wildcard include/config/CGROUP_SCHED) \
    $(wildcard include/config/BLK_DEV_IO_TRACE) \
    $(wildcard include/config/MEMCG_V1) \
    $(wildcard include/config/COMPAT_BRK) \
    $(wildcard include/config/CGROUPS) \
    $(wildcard include/config/BLK_CGROUP) \
    $(wildcard include/config/PSI) \
    $(wildcard include/config/PAGE_OWNER) \
    $(wildcard include/config/EVENTFD) \
    $(wildcard include/config/ARCH_HAS_CPU_PASID) \
    $(wildcard include/config/X86_BUS_LOCK_DETECT) \
    $(wildcard include/config/TASK_DELAY_ACCT) \
    $(wildcard include/config/STACKPROTECTOR) \
    $(wildcard include/config/ARCH_HAS_SCALED_CPUTIME) \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_GEN) \
    $(wildcard include/config/POSIX_CPUTIMERS) \
    $(wildcard include/config/POSIX_CPU_TIMERS_TASK_WORK) \
    $(wildcard include/config/KEYS) \
    $(wildcard include/config/SYSVIPC) \
    $(wildcard include/config/DETECT_HUNG_TASK) \
    $(wildcard include/config/IO_URING) \
    $(wildcard include/config/AUDIT) \
    $(wildcard include/config/AUDITSYSCALL) \
    $(wildcard include/config/UBSAN) \
    $(wildcard include/config/UBSAN_TRAP) \
    $(wildcard include/config/TASK_XACCT) \
    $(wildcard include/config/CPUSETS) \
    $(wildcard include/config/X86_CPU_RESCTRL) \
    $(wildcard include/config/FUTEX) \
    $(wildcard include/config/COMPAT) \
    $(wildcard include/config/PERF_EVENTS) \
    $(wildcard include/config/RSEQ) \
    $(wildcard include/config/DEBUG_RSEQ) \
    $(wildcard include/config/FAULT_INJECTION) \
    $(wildcard include/config/LATENCYTOP) \
    $(wildcard include/config/FUNCTION_GRAPH_TRACER) \
    $(wildcard include/config/BCACHE) \
    $(wildcard include/config/SECURITY) \
    $(wildcard include/config/BPF_SYSCALL) \
    $(wildcard include/config/KSTACK_ERASE) \
    $(wildcard include/config/KSTACK_ERASE_METRICS) \
    $(wildcard include/config/X86_MCE) \
    $(wildcard include/config/KRETPROBES) \
    $(wildcard include/config/RETHOOK) \
    $(wildcard include/config/ARCH_HAS_PARANOID_L1D_FLUSH) \
    $(wildcard include/config/RV) \
    $(wildcard include/config/RV_PER_TASK_MONITORS) \
    $(wildcard include/config/USER_EVENTS) \
    $(wildcard include/config/UNWIND_USER) \
    $(wildcard include/config/SCHED_PROXY_EXEC) \
  /home/uuu/linux/include/uapi/linux/sched.h \
  /home/uuu/linux/include/linux/pid_types.h \
  /home/uuu/linux/include/linux/sem_types.h \
  /home/uuu/linux/include/linux/shm.h \
  /home/uuu/linux/arch/arm/include/asm/shmparam.h \
  /home/uuu/linux/include/linux/kmsan_types.h \
  /home/uuu/linux/include/linux/plist_types.h \
  /home/uuu/linux/include/linux/hrtimer_types.h \
  /home/uuu/linux/include/linux/timerqueue_types.h \
  /home/uuu/linux/include/linux/seccomp_types.h \
    $(wildcard include/config/SECCOMP) \
  /home/uuu/linux/include/linux/resource.h \
  /home/uuu/linux/include/uapi/linux/resource.h \
  /home/uuu/linux/arch/arm/include/generated/uapi/asm/resource.h \
  /home/uuu/linux/include/asm-generic/resource.h \
  /home/uuu/linux/include/uapi/asm-generic/resource.h \
  /home/uuu/linux/include/linux/latencytop.h \
  /home/uuu/linux/include/linux/sched/prio.h \
  /home/uuu/linux/include/linux/sched/types.h \
  /home/uuu/linux/include/linux/signal_types.h \
    $(wildcard include/config/OLD_SIGACTION) \
  /home/uuu/linux/include/uapi/linux/signal.h \
  /home/uuu/linux/arch/arm/include/asm/signal.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/signal.h \
  /home/uuu/linux/include/uapi/asm-generic/signal-defs.h \
  /home/uuu/linux/arch/arm/include/uapi/asm/sigcontext.h \
  /home/uuu/linux/arch/arm/include/generated/uapi/asm/siginfo.h \
  /home/uuu/linux/include/uapi/asm-generic/siginfo.h \
  /home/uuu/linux/include/linux/syscall_user_dispatch_types.h \
  /home/uuu/linux/include/linux/netdevice_xmit.h \
    $(wildcard include/config/NET_EGRESS) \
    $(wildcard include/config/NET_ACT_MIRRED) \
    $(wildcard include/config/NF_DUP_NETDEV) \
  /home/uuu/linux/include/linux/task_io_accounting.h \
    $(wildcard include/config/TASK_IO_ACCOUNTING) \
  /home/uuu/linux/include/linux/posix-timers_types.h \
  /home/uuu/linux/include/uapi/linux/rseq.h \
  /home/uuu/linux/include/linux/kcsan.h \
  /home/uuu/linux/include/linux/rv.h \
    $(wildcard include/config/RV_LTL_MONITOR) \
    $(wildcard include/config/RV_REACTORS) \
  /home/uuu/linux/include/linux/tracepoint-defs.h \
  /home/uuu/linux/include/linux/unwind_deferred_types.h \
  /home/uuu/linux/arch/arm/include/generated/asm/kmap_size.h \
  /home/uuu/linux/include/asm-generic/kmap_size.h \
    $(wildcard include/config/DEBUG_KMAP_LOCAL) \
  /home/uuu/linux/include/linux/sched/ext.h \
    $(wildcard include/config/EXT_GROUP_SCHED) \
  /home/uuu/linux/arch/arm/include/asm/mmu.h \
    $(wildcard include/config/CPU_HAS_ASID) \
    $(wildcard include/config/VDSO) \
  /home/uuu/linux/include/linux/page-flags.h \
    $(wildcard include/config/PAGE_IDLE_FLAG) \
    $(wildcard include/config/ARCH_USES_PG_ARCH_2) \
    $(wildcard include/config/ARCH_USES_PG_ARCH_3) \
    $(wildcard include/config/MIGRATION) \
    $(wildcard include/config/HUGETLB_PAGE_OPTIMIZE_VMEMMAP) \
    $(wildcard include/config/DEBUG_KMAP_LOCAL_FORCE_MAP) \
  /home/uuu/linux/include/linux/local_lock.h \
  /home/uuu/linux/include/linux/local_lock_internal.h \
  /home/uuu/linux/include/linux/zswap.h \
    $(wildcard include/config/ZSWAP) \
  /home/uuu/linux/include/linux/memory_hotplug.h \
    $(wildcard include/config/ARCH_HAS_ADD_PAGES) \
    $(wildcard include/config/MEMORY_HOTREMOVE) \
  /home/uuu/linux/include/linux/notifier.h \
  /home/uuu/linux/include/linux/srcu.h \
    $(wildcard include/config/TINY_SRCU) \
    $(wildcard include/config/NEED_SRCU_NMI_SAFE) \
  /home/uuu/linux/include/linux/rcu_segcblist.h \
  /home/uuu/linux/include/linux/srcutree.h \
  /home/uuu/linux/include/linux/rcu_node_tree.h \
    $(wildcard include/config/RCU_FANOUT) \
    $(wildcard include/config/RCU_FANOUT_LEAF) \
  /home/uuu/linux/include/linux/topology.h \
    $(wildcard include/config/USE_PERCPU_NUMA_NODE_ID) \
    $(wildcard include/config/SCHED_SMT) \
    $(wildcard include/config/GENERIC_ARCH_TOPOLOGY) \
  /home/uuu/linux/include/linux/arch_topology.h \
  /home/uuu/linux/arch/arm/include/asm/topology.h \
    $(wildcard include/config/ARM_CPU_TOPOLOGY) \
    $(wildcard include/config/BL_SWITCHER) \
  /home/uuu/linux/include/asm-generic/topology.h \
  /home/uuu/linux/include/linux/sysctl.h \
    $(wildcard include/config/SYSCTL) \
  /home/uuu/linux/include/uapi/linux/sysctl.h \
  /home/uuu/linux/include/linux/elf.h \
    $(wildcard include/config/ARCH_HAVE_EXTRA_ELF_NOTES) \
    $(wildcard include/config/ARCH_USE_GNU_PROPERTY) \
    $(wildcard include/config/ARCH_HAVE_ELF_PROT) \
  /home/uuu/linux/arch/arm/include/asm/elf.h \
  /home/uuu/linux/arch/arm/include/asm/user.h \
  /home/uuu/linux/include/uapi/linux/elf.h \
  /home/uuu/linux/include/uapi/linux/elf-em.h \
  /home/uuu/linux/include/linux/kobject.h \
    $(wildcard include/config/UEVENT_HELPER) \
    $(wildcard include/config/DEBUG_KOBJECT_RELEASE) \
  /home/uuu/linux/include/linux/sysfs.h \
  /home/uuu/linux/include/linux/kernfs.h \
    $(wildcard include/config/KERNFS) \
  /home/uuu/linux/include/linux/idr.h \
  /home/uuu/linux/include/linux/radix-tree.h \
  /home/uuu/linux/include/linux/xarray.h \
    $(wildcard include/config/XARRAY_MULTI) \
  /home/uuu/linux/include/linux/sched/mm.h \
    $(wildcard include/config/MMU_LAZY_TLB_REFCOUNT) \
    $(wildcard include/config/ARCH_HAS_MEMBARRIER_CALLBACKS) \
    $(wildcard include/config/ARCH_HAS_SYNC_CORE_BEFORE_USERMODE) \
  /home/uuu/linux/include/linux/sync_core.h \
    $(wildcard include/config/ARCH_HAS_PREPARE_SYNC_CORE_CMD) \
  /home/uuu/linux/include/linux/sched/coredump.h \
  /home/uuu/linux/include/linux/kobject_ns.h \
  /home/uuu/linux/include/linux/moduleparam.h \
    $(wildcard include/config/ALPHA) \
    $(wildcard include/config/PPC64) \
  /home/uuu/linux/include/linux/rbtree_latch.h \
  /home/uuu/linux/include/linux/error-injection.h \
  /home/uuu/linux/include/asm-generic/error-injection.h \
  /home/uuu/linux/include/linux/dynamic_debug.h \
  /home/uuu/linux/arch/arm/include/asm/module.h \
    $(wildcard include/config/ARM_UNWIND) \
  /home/uuu/linux/include/asm-generic/module.h \
    $(wildcard include/config/HAVE_MOD_ARCH_SPECIFIC) \
  /home/uuu/linux/arch/arm/include/asm/unwind.h \
  /home/uuu/linux/include/linux/build-salt.h \
    $(wildcard include/config/BUILD_SALT) \
  /home/uuu/linux/include/linux/elfnote.h \
  /home/uuu/linux/include/linux/elfnote-lto.h \
    $(wildcard include/config/LTO) \
  /home/uuu/linux/include/linux/vermagic.h \
    $(wildcard include/config/PREEMPT_BUILD) \
  /home/uuu/linux/include/generated/utsrelease.h \
  /home/uuu/linux/arch/arm/include/asm/vermagic.h \

.module-common.o: $(deps_.module-common.o)

$(deps_.module-common.o):
