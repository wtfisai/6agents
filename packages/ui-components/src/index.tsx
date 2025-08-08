import React from 'react';

export type ButtonProps = Readonly<{
  children: React.ReactNode;
  onClick?: () => void;
}>;

export function Button({ children, onClick }: ButtonProps): JSX.Element {
  return (
    <button style={{ padding: '8px 12px', background: '#4f46e5', color: '#fff', borderRadius: 6 }} onClick={onClick}>
      {children}
    </button>
  );
}
