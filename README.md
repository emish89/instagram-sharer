# instagram-sharer

Instagram share on stories capacitor plugin.

You can share your images as IG story with new Open Graph API that needs the Facebook App ID. 

## Install

```bash
npm install @emish89/capacitor-instagram-sharer
npx cap sync
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

* [`shareToStory(...)`](#sharetostory)

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

--------------------

</docgen-api>
