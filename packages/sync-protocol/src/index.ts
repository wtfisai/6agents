import * as Y from 'yjs';

export type SyncMessage = {
  type: 'update';
  payload: Uint8Array;
};

export function encodeUpdate(doc: Y.Doc): Uint8Array {
  const update = Y.encodeStateAsUpdate(doc);
  return update;
}
