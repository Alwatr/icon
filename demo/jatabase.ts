import {Jatabase} from '@alwatr/jatabase';

import type {DocumentObject} from '@alwatr/jatabase';

interface User extends DocumentObject {
  fname: string;
  lname: string;
  email: string;
  token?: string;
}

const db = new Jatabase<User>('user-list', 'temp');

// await db.ready
// or
db.ready.then(() => {
  console.log('db loaded and ready to access.');

  let ali = db.get('alimd');

  if (ali == null) {
    console.log('ali not found');
    ali = {
      _id: 'alimd',
      fname: 'Ali',
      lname: 'Mihandoost',
      email: 'ali@mihandoost.com',
    };
  } else {
    console.log('ali found: %o', ali);
    /**
     * {
     *   _id: 'alimd',
     *   fname: 'Ali',
     *   lname: 'MM',
     *   email: 'i@ali.md',
     * }
     */

    ali.token = Math.random().toString(36).substring(2, 15);
  }

  db.set(ali);

  db.set({
    _id: 'fmd',
    fname: 'Fatemeh',
    lname: 'Mihandoost',
    email: 'Fatemeh@mihandoost.com',
    token: Math.random().toString(36).substring(2, 15),
  });
});
