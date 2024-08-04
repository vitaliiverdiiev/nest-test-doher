import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cors from 'cors';

async function bootstrap() {
  const PORT = process.env.PORT || 3303;
  const app = await NestFactory.create(AppModule);
  app.use(
    cors({
      origin: '*',
      methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
      credentials: true,
    }),
  );
  await app.listen(PORT, () => console.log(`Starting app ${PORT}`));
}

bootstrap();
