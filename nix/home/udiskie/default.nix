{
  # Automounter for removable media.
  services.udiskie = {
    automount = true;
    notify = true;
  };
}
