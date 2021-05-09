import hello from './index';


describe('hello', function () {

    test('given name, when called, then returns greeting', () => {
        expect(hello('dave')).toBe("hello dave");
    });

});
