import { registerPlugin } from '@capacitor/core';

import type { InstagramSharerPlugin } from './definitions';

const InstagramSharer = registerPlugin<InstagramSharerPlugin>('InstagramSharer', {
  web: () => import('./web').then((m) => new m.InstagramSharerWeb()),
});

export * from './definitions';
export { InstagramSharer };
