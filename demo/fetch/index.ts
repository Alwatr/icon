import {fetch} from '@alwatr/fetch';

const buttons = document.querySelectorAll('button') as NodeListOf<HTMLButtonElement>;

for (const button of buttons) {
  const buttonURL = button.dataset.url;

  if (button && buttonURL) {
    button.addEventListener('click', async () => {
      if (button.classList.contains('loading')) return;

      button.classList.add('loading');
      try {
        const response = await fetch(buttonURL);
        console.log('%s | %O', buttonURL, response);
      }
      catch (error) {
        console.error('%s | %O', buttonURL, error);
      }
      button.classList.remove('loading');
    });
  }
}