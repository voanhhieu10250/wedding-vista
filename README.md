# Before deploy to production

1. Set real host for email configuration
2. If you're using Ubuntu 20.04, you need to follow these step to fix the "image variant" problems. 

    - The FFI version included with Ubuntu 20.04 in too old. So, the key is to uninstall the gem and then reinstall it with the correct flag to force it to ignore the system ffi library.

    - First uninstall the gem:
      - gem uninstall ffi

    - Then reinstall it with disable flag:
      - gem install ffi -- --disable-system-libffi

    - Now the ffi gem should use its own libffi library instead of the system library.