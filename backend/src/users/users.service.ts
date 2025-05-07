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
}
