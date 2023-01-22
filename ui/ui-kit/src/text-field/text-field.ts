import {css, customElement, html, property, ifDefined, type PropertyValues} from '@alwatr/element';

import '@alwatr/icon';

import {AlwatrSurface} from '../card/surface-element.js';

declare global {
  interface HTMLElementTagNameMap {
    'alwatr-text-field': AlwatrTextField;
  }
}

export type InputType =
  | 'text'
  | 'search'
  | 'tel'
  | 'url'
  | 'email'
  | 'password'
  | 'datetime'
  | 'date'
  | 'month'
  | 'week'
  | 'time'
  | 'datetime-local'
  | 'number';

/**
 * Alwatr outlined text field.
 */
@customElement('alwatr-text-field')
export class AlwatrTextField extends AlwatrSurface {
  static override styles = [
    AlwatrSurface.styles,
    css`
      :host {
        --_surface-color-on: var(--sys-color-on-surface-variant-hsl);
        display: block;
        padding: var(--sys-spacing-track) calc(2 * var(--sys-spacing-track));
        font-family: var(--sys-typescale-body-large-font-family-name);
        font-weight: var(--sys-typescale-body-large-font-weight);
        font-size: var(--sys-typescale-body-large-font-size);
        letter-spacing: var(--sys-typescale-body-large-letter-spacing);
        line-height: var(--sys-typescale-body-large-line-height);
        border-radius: var(--sys-radius-xsmall);
        background-color: transparent;
      }

      :host([stated][outlined]) {
        box-shadow: none;
      }

      input {
        display: block;
        padding: 0;
        font: inherit;
        width: 100%;
        border-radius: inherit;
        border: none;
        outline: transparent;
        text-align: inherit;
        background-color: transparent;
        color: var(--sys-color-on-surface);
        caret-color: var(--sys-color-primary);
      }

      /* So not group these selectors! */
      input::placeholder {
        font: inherit;
        color: var(--sys-color-on-surface-variant);
      }
      input::-webkit-input-placeholder {
        font: inherit;
        color: var(--sys-color-on-surface-variant);
      }
      input::-moz-placeholder{
        font: inherit;
        color: var(--sys-color-on-surface-variant);
      }

      input[type=number] {
        -moz-appearance: textfield;
      }
    `,
  ];

  @property({type: String})
    type: InputType = 'text';

  @property({type: String})
    placeholder?: string;

  inputElement: HTMLInputElement | null = null;

  override render(): unknown {
    this._logger.logMethod('render');
    return html`<input type=${this.type} placeholder=${ifDefined(this.placeholder)}></input>`;
  }

  protected override firstUpdated(changedProperties: PropertyValues<this>): void {
    super.firstUpdated(changedProperties);
    this.inputElement = this.renderRoot.querySelector('input');
    this.addEventListener('click', () => this.inputElement?.focus());
  }
}