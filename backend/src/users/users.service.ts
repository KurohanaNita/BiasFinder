import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { users } from '@prisma/client';

@Injectable() // en gros injectacle c'est pour dire que ce service va être injecté dans d'autres classes
export class UsersService {
  constructor(private prisma: PrismaService) {}

  // une fonction ici va retourner une promesse qui va retourner un tableau d'utilisateurs
  // on recoit soit le tableau d'utilisateurs soit une erreur
  async findAll(): Promise<users[]> {
    try {
      return await this.prisma.users.findMany();
    } catch (error) {
      console.error('Unable to retrieve users:', error);
      throw new Error('Unable to retrieve users');
    }
  }

  async findOrCreateUser(user: any) {
    const currentUser = user;

    try {
      const existingUser = await this.prisma.users.findUnique({
        where: {
          email: currentUser.email,
        },
      });
      if (existingUser === null) {
        const newUser = await this.prisma.users.create({
          data: {
            email: currentUser.email,
            oauth_provider: currentUser.provider,
            oauth_id: currentUser.oauthId,
          },
        });
      } else {
        const updatedUser = await this.prisma.users.update({
          where: {
            email: currentUser.email,
          },
          data: {
            oauth_provider: currentUser.provider,
            oauth_id: currentUser.oauthId,
          },
        });
      }
    } catch (error) {
      console.error('Unable to retrieve users:', error);
      throw new Error('Unable to retrieve users');
    }
  }
}
