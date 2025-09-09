import { WebPlugin } from '@capacitor/core';

import type { InstagramSharerPlugin } from './definitions';

export class InstagramSharerWeb extends WebPlugin implements InstagramSharerPlugin {
  async shareToStory(options: { imageBase64: string; appId: string }): Promise<void> {
    // Evita l'avviso "unused variable" e logga per debugging
    console.log('Share options:', options);

    // Lancia un errore standard di Capacitor per le funzioni non implementate sul web
    throw this.unimplemented('Sharing directly to Instagram Stories is not available on the web.');
  }
}
