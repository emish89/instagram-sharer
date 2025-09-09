export interface InstagramSharerPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
