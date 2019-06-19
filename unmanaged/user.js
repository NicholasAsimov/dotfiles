// firefox user preferences

// Don't show about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// Disable alt-key opening menu bar (interferes with media keybinds e.g. Alt+3)
user_pref("ui.key.menuAccessKeyFocuses", false);

// Make URL bar behaviour similar to Chrome
user_pref("browser.urlbar.clickSelectsAll", true);
user_pref("browser.urlbar.doubleClickSelectsAll", false);

// Compact toolbar
user_pref("browser.uidensity", 1);

// Move sidebar to the right
user_pref("sidebar.position_start", false);

// Dock developer toolbox to the right
user_pref("devtools.toolbox.host", "right");

// Show notifications in bottom-right corner
user_pref("ui.alertNotificationOrigin", 0);

// Enable WebRender and hardware acceleration
user_pref("gfx.webrender.all", true);
user_pref("layers.acceleration.force-enabled", true);

// Font settings
user_pref("font.default.x-cyrillic", "sans-serif");
user_pref("font.default.x-western", "sans-serif");
user_pref("font.name.monospace.x-cyrillic", "Fira Mono");
user_pref("font.name.monospace.x-western", "Fira Mono");
user_pref("font.name.sans-serif.x-cyrillic", "Roboto");
user_pref("font.name.sans-serif.x-western", "Roboto");
user_pref("font.name.serif.x-cyrillic", "Roboto");
user_pref("font.name.serif.x-western", "Roboto");
user_pref("font.size.variable.x-cyrillic", 16);
user_pref("font.size.variable.x-western", 16);
user_pref("font.size.fixed.x-cyrillic", 13);
user_pref("font.size.fixed.x-western", 13);
