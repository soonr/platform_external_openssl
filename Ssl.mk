#######################################
# target static library
include $(CLEAR_VARS)
LOCAL_SHARED_LIBRARIES := $(log_shared_libraries)
LOCAL_C_INCLUDES := $(log_c_includes)

# The static library should be used in only unbundled apps
# and we don't have clang in unbundled build yet.
LOCAL_SDK_VERSION := 9

LOCAL_SRC_FILES += $(target_src_files)
LOCAL_CFLAGS += $(target_c_flags)
LOCAL_C_INCLUDES += $(target_c_includes)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libssl_static
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/android-config.mk $(LOCAL_PATH)/Ssl.mk
include $(LOCAL_PATH)/Ssl-config-target.mk
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_STATIC_LIBRARY)

#######################################
# target shared library
include $(CLEAR_VARS)
LOCAL_SHARED_LIBRARIES := $(log_shared_libraries)
LOCAL_C_INCLUDES := $(log_c_includes)

# If we're building an unbundled build, don't try to use clang since it's not
# in the NDK yet. This can be removed when a clang version that is fast enough
# in the NDK.
ifeq (,$(TARGET_BUILD_APPS))
LOCAL_CLANG := true
else
LOCAL_SDK_VERSION := 9
endif

LOCAL_SHARED_LIBRARIES += libcrypto
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libssl
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/android-config.mk $(LOCAL_PATH)/Ssl.mk
include $(LOCAL_PATH)/Ssl-config-target.mk
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_SHARED_LIBRARY)
