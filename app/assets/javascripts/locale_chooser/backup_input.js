var InputBackup = (function ($) {
  var backup_exists,
      restore,
      save,
      get_saved_inputs,
      init,
      Cookie;

  Cookie = (function () {
    var read,
        write,
        erase,
        get,
        cookie_name = "openproject_input_backup",
        cookie_name_regexp = new RegExp("^" + cookie_name + "=");

    read = function () {
      var backup_cookie = get(),
          key_value_pairs = {};

      if (backup_cookie === undefined) {
        return key_value_pairs;
      }

      backup_cookie = decodeURIComponent(backup_cookie.gsub(cookie_name_regexp, ""));

      backup_cookie.split(",").map(function (entry) {
        var key_value = entry.split("=");

        key_value_pairs[key_value[0]] = key_value[1];
      });

      return key_value_pairs;
    };

    write = function (value) {
      document.cookie = cookie_name + "=" + encodeURIComponent(value);
    };

    erase = function () {
      document.cookie = cookie_name + "=";
    };

    get = function () {
      var cookie;

      cookie = $.grep(document.cookie.split(";"), function (cookie) {
        return cookie.match(cookie_name) !== null;
      }).first();

      return cookie;
    };

    return {
      read : read,
      write : write,
      erase : erase
    };
  }());

  save = function () {
    var inputs = get_saved_inputs(),
        cookie_string;

    inputs = $.grep(inputs, function (input_dom) {
      var input = $(input_dom),
          value = input.val(),
          key = input.attr('id');

      return (value !== "" && key !== undefined);
    });

    cookie_string = inputs.map(function (input_dom, index) {
      var input = $(input_dom),
          value,
          key = input.attr('id'),
          ret;

      if (input.is('select')) {
        value = parseInt(input.find('option[value=' + input.val() + ']').prevAll('option').size(), 10) + 1;
      }
      else if (input.is('[type=checkbox]')) {
        value = input.attr('checked') ? "1" : "0";
      }
      else {
        value = input.val();
      }

      return key + "=" + value;

    }).join(",");

    Cookie.write(cookie_string);
  };

  restore = function () {
    var inputs = get_saved_inputs(),
        key_value_pairs = Cookie.read();

    $.grep(inputs, function (input_dom) {
      var input = $(input_dom),
          key = input.attr('id');

      return key_value_pairs[key] !== undefined;

    }).each(function (input_dom) {
      var input = $(input_dom),
          key = input.attr('id');

      if (input.is('select')) {
        input.find('option:nth-child(' + key_value_pairs[key] + ')').attr('selected', true);
      }
      else if (input.is('[type=checkbox]')) {
        input.attr('checked', key_value_pairs[key] === "1");
      }
      else {
        input.val(key_value_pairs[key]);
      }
    });
  };

  get_saved_inputs = function () {
    var inputs = $('form').find('input, textarea, select');

    inputs = inputs.not('input[type=hidden], input[type=submit], .locales_chooser_ignore');

    return inputs;
  };

  init = function () {
    restore();

    $('.locales_chooser form').submit(save);
  };

  $('document').ready(init);
}(jQuery));
