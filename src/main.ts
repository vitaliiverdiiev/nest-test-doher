import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import cors from 'cors';

async function bootstrap() {
  const PORT = process.env.PORT || 3303;
  const app = await NestFactory.create(AppModule);
  app.use(
    cors({
      credentials: true,
      origin: '*',
    }),
  );
  await app.listen(PORT, () => console.log(`Starting app ${PORT}`));
}

bootstrap();
