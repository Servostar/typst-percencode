
#let percent-decode(message) = {
  message.replace(
    regex(`(%[a-fA-F0-9]{2})+`.text),
    // Dirty workaround as I couldn*t find an offical way of
    // converting a hex string to an integer programatically.
    matches => str.from-unicode(eval("0x" + matches.text.split("%").join())),
  )
}
