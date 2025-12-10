# instagram-sharer

Instagram share on stories capacitor plugin.

You can share your images as IG story with new Open Graph API that needs the Facebook App ID.

## Install

```bash
npm install @emish89/capacitor-instagram-sharer
npx cap sync
```

and put in the `Info.plist` file :

```bash
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>instagram</string>
		<string>instagram-stories</string>
	</array>
```

and in the `AndroidManifest.xml` :

```bash
<queries>
        <package android:name="com.instagram.android" />
    </queries>
```

## Sample Usage

```js
await InstagramSharer.shareToStory({
  imageBase64: base64String,
  appId: facebookAppId(),
});
```

## API

<docgen-index>

- [`shareToStory(...)`](#sharetostory)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### shareToStory(...)

```typescript
shareToStory(options: { imageBase64: string; appId: string; }) => Promise<void>
```

| Param         | Type                                                 |
| ------------- | ---------------------------------------------------- |
| **`options`** | <code>{ imageBase64: string; appId: string; }</code> |

---

</docgen-api>

## Publishing

To publish this package to npm:

1. Make sure you are logged in: `npm login` (use OTP if your account has 2FA).
2. Run a dry run to verify what will be published:

```bash
npm publish --dry-run --access public
```

3. Publish the package (for scoped packages use `--access public`):

```bash
npm publish --access public
```

If you use CI, create an automation token on https://www.npmjs.com/ (Account → Access Tokens) and set it as `NPM_TOKEN` in your pipeline. For more details see the npm documentation.
