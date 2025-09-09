export interface InstagramSharerPlugin {
  shareToStory(options: { imageBase64: string; appId: string }): Promise<void>;
}
