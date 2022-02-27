use std::os::raw::{c_char};
use std::ffi::{CString, CStr};
use std::env;

#[no_mangle]
pub extern fn rust_greeting(to: *const c_char) -> *mut c_char {
  let c_str = unsafe { CStr::from_ptr(to) };
  let recipient = match c_str.to_str() {
    Err(_) => "there",
    Ok(string) => string, 
  };
  CString::new("Hello ".to_owned() + recipient).unwrap().into_raw()
}

#[no_mangle]
pub extern fn rust_get_platform() -> *mut c_char {

  CString::new(env::consts::OS).unwrap().into_raw()
}
