import '../models/contact.dart';

List<Contact> contacts() {
  return <Contact>[
    Contact(name: 'Email', link: 'mailto:dev.thantzin@gmail.com'),
    Contact(name: 'Github', link: 'https://github.com/tz-thantzin'),
    Contact(
      name: 'LinkedIn',
      link: 'https://www.linkedin.com/in/thant-zin-9a855524/',
    ),
    Contact(name: 'Facebook', link: 'https://www.facebook.com/devthantzin/'),
    Contact(name: 'Instagram', link: 'https://www.instagram.com/dev.thantzin/'),
  ];
}

List<Contact> footerContacts() {
  return <Contact>[
    Contact(name: 'Email', link: 'mailto:dev.thantzin@gmail.com'),
    Contact(name: 'Github', link: 'https://github.com/tz-thantzin'),
    Contact(
      name: 'LinkedIn',
      link: 'https://www.linkedin.com/in/thant-zin-9a855524/',
    ),
  ];
}
