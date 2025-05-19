
/// Encode the given string with percent encoding
/// escaping all UTF-8 characters.
/// Based on RFC 3986 section 2.1.
#let percent-encode(url, exclude: regex) = {
  return url
    .codepoints()
    .map(char => {
      if exclude in char {
        char
      } else {
        // Convert grapheme cluster to bytes representing the unicode point.
        // Then drop zero bytes, only the least significant non-zero bytes are of use.
        // At last, convert each byte to uppercase hex and prepend a '%'.
        array(char.to-unicode().to-bytes(endian: "big"))
          .filter(cp => cp != 0)
          .map(byte => "%" + upper(str(byte, base: 16)))
          .join("")
      }
    })
    .join()
}

/// Escapes all characters except:
/// A–Z a–z 0–9 - _ . ! ~ * ' ( ) ; / ? : @ & = + $ , #
/// conforming to RFC 2396.
#let url-encode(url) = {
  percent-encode(url, exclude: regex(`[a-zA-Z0-9\-_.!~*'();/?:@&=+$,#]`.text))
}
