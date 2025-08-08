export type ColorTokens = {
  primary: string;
  secondary: string;
  background: string;
  text: string;
};

export const colors: Readonly<ColorTokens> = Object.freeze({
  primary: '#4f46e5',
  secondary: '#06b6d4',
  background: '#ffffff',
  text: '#0f172a'
});
