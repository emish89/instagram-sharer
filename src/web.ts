import { WebPlugin } from '@capacitor/core';

import type { InstagramSharerPlugin } from './definitions';

export class InstagramSharerWeb extends WebPlugin implements InstagramSharerPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
