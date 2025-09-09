import { InstagramSharer } from 'instagram-sharer';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    InstagramSharer.echo({ value: inputValue })
}
