import express, { Request, Response } from 'express';
import cors from 'cors';

const app = express();
app.use(cors());
app.use(express.json());

const PORT: number = Number(process.env.API_PORT ?? 3001);

app.get('/health', (_req: Request, res: Response) => {
  res.json({ ok: true, service: 'api', ts: new Date().toISOString() });
});

app.listen(PORT, () => {
  // eslint-disable-next-line no-console
  console.log(`[api] listening on http://localhost:${PORT}`);
});
